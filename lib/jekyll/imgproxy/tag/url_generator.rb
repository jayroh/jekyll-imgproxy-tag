# frozen_string_literal: true

module Jekyll
  module Imgproxy
    class Tag
      class UrlGenerator
        def initialize(config, options)
          @config = config
          @options = options
        end

        def url
          path        = PathBuilder.new(config, options).build
          hmac        = HmacBuilder.new(config, path).build
          signed_path = "/#{hmac}#{path}"

          "#{config.base_url}#{signed_path}"
        end

        protected

        attr_reader :config, :options
      end
    end
  end
end
