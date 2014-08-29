module Jekyll
  module LayerVault
    module Common
      PARAM_REGEX = /"(.+?)"/

      private

      def valid_parameters?
        @text.scan(/"/).length.even?
      end
    end
  end
end
