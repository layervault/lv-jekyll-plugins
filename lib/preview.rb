require 'liquid'
require 'lib/common'

# {% lv_preview "File.psd" %}
# {% lv_preview "File.psd" "1" %}
# {% lv_preview "File.psd" "1" "2" %}

module Jekyll
  module LayerVault
    class Preview < Liquid::Tag
      include Common

      URL_BASE = "https://layervault.com".freeze

      def initialize(tag_name, text, tokens)
        super
        @text = text
      end

      def render(context)
        return @text unless valid_parameters?

        config = context.registers[:site].config
        file, revision, page = parse_parameters

        url = File.join(URL_BASE, config['organization'], config['project'], file)
        url = File.join(url, revision) unless revision.nil?

        if page.nil?
          url = File.join(url, 'preview')
        else
          url = File.join(url, 'previews', page)
        end

        url += "?raw=1"
      end

      private

      def parse_parameters
        @text.scan(PARAM_REGEX).
          flatten.
          tap { |m| m[1] = nil if m[1] == '-' }
      end
    end
  end
end

Liquid::Template.register_tag('lv_preview', Jekyll::LayerVault::Preview)
