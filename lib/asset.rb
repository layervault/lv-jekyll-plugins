require 'liquid'

module Jekyll
  module LayerVault
    class Asset < Liquid::Tag
      PARAM_REGEX = /"(.+?)"/
      URL_BASE = "https://layervault.com".freeze

      def initialize(tag_name, text, tokens)
        super
        @text = text
      end

      def render(context)
        return @text unless valid_parameters?

        config = context.registers[:site].config
        file, revision, asset = parse_parameters.map(&:first)

        url = File.join(URL_BASE, config['organization'], config['project'], file)
        url = File.join(url, revision) unless revision.nil?
        url = File.join(url, 'assets', asset)
        url += "?raw=1"
      end

      private

      def valid_parameters?
        @text.scan(/"/).length.even?
      end

      def parse_parameters
        @text.scan(PARAM_REGEX).
          tap { |m| m.insert 1, [] if m.length == 2 }.
          tap { |m| m[1] = [] if m[1][0] == '-' }
      end
    end
  end
end

Liquid::Template.register_tag('lv_asset', Jekyll::LayerVault::Asset)
