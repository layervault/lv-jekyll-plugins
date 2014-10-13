require 'liquid'
require 'plugins/common'

# {% lv_preview "File.psd" %}
# {% lv_preview "File.psd" "1" %}
# {% lv_preview "File.psd" "1" "2" %}

module Jekyll
  module LayerVault
    class Preview < Liquid::Tag
      include Common

      def initialize(tag_name, text, tokens)
        super
        @text = text.strip
      end

      def render(context)
        return @text unless valid_parameters?

        config = context.registers[:site].config
        file, revision, page = parse_parameters

        url = File.join(URL_BASE, config['organization'], config['project'], file)
        url = File.join(url, 'revisions', revision) unless revision.nil?
        url = File.join(url, 'previews', page)

        url += "?raw=1"
      end

      private

      def parse_parameters
        @text.
          scan(PARAM_REGEX).
          flatten.
          tap { |m| m.push nil if m.length == 1 }.
          tap { |m| m.push '1' if m.length == 2 }.
          tap { |m| m[1] = nil if m[1] == '-' }
      end
    end

    class PreviewExample < Preview
      def render(context)
        "{% lv_preview #{@text} %}"
      end
    end
  end
end

Liquid::Template.register_tag('lv_preview', Jekyll::LayerVault::Preview)
Liquid::Template.register_tag('lv_preview_example', Jekyll::LayerVault::PreviewExample)
