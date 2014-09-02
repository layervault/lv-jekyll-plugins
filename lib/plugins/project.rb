require 'liquid'
require 'plugins/common'

module Jekyll
  module LayerVault
    class Project < Liquid::Tag
      include Common

      def render(context)
        config = context.registers[:site].config
        File.join(URL_BASE, config['organization'], config['project'])
      end
    end
  end
end

Liquid::Template.register_tag('lv_project', Jekyll::LayerVault::Project)
