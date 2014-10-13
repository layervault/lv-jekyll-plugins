require 'liquid'
require 'plugins/common'

module Jekyll
  module LayerVault
    class Asset < Liquid::Tag
      include Common

      def initialize(tag_name, text, tokens)
        super
        @text = text.strip
      end

      def render(context)
        return @text unless valid_parameters?

        config = context.registers[:site].config
        file, revision, asset = parse_parameters

        url = File.join(URL_BASE, config['organization'], config['project'], file)
        url = File.join(url, 'revisions', revision) unless revision.nil?
        url = File.join(url, 'assets', asset)
        url += "?raw=1"
      end

      private

      def parse_parameters
        @text.scan(PARAM_REGEX).
          tap { |m| m.insert 1, [] if m.length == 2 }.
          tap { |m| m[1] = [] if m[1][0] == '-' }.
          map(&:first)
      end
    end

    class ExampleAsset < Asset
      def render(context)
        "{% lv_asset #{@text} %}"
      end
    end
  end
end

Liquid::Template.register_tag('lv_asset', Jekyll::LayerVault::Asset)
Liquid::Template.register_tag('lv_asset_example', Jekyll::LayerVault::ExampleAsset)
