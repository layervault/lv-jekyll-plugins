require 'liquid'
require 'plugins/common'

# {% lv_download "File.psd" %}
# {% lv_download "File.psd" "2" %}

module Jekyll
  module LayerVault
    class Download < Liquid::Tag
      include Common

      def initialize(tag_name, text, tokens)
        super
        @text = text.strip
      end

      def render(context)
        return @text unless valid_parameters?

        config = context.registers[:site].config
        file, revision = parse_parameters

        url = File.join(URL_BASE, config['organization'], config['project'], file)
        url = File.join(url, 'revisions', revision) unless revision.nil?
        url += "?raw=1"
      end

      private

      def parse_parameters
        @text.
          scan(PARAM_REGEX).
          flatten.
          tap { |m| m[1] = nil if m[1] == '-' }
      end
    end

    class DownloadExample < Download
      def render(context)
        "{% lv_download #{@text.gsub 'lv_download_example', 'lv_download' } %}"
      end
    end
  end
end

Liquid::Template.register_tag('lv_download', Jekyll::LayerVault::Download)
Liquid::Template.register_tag('lv_download_example', Jekyll::LayerVault::DownloadExample)
