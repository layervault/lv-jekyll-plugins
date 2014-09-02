module Jekyll
  module LayerVault
    module Common
      URL_BASE = "https://layervault.com".freeze
      PARAM_REGEX = /"(.+?)"/

      private

      def valid_parameters?
        @text.scan(/"/).length.even?
      end
    end
  end
end
