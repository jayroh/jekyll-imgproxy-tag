# frozen_string_literal: true

module Jekyll
  module Imgproxy
    class Tag
      class ImgproxyConfig
        attr_reader \
          :base_url,
          :key,
          :salt,
          :aws_bucket

        def initialize
          @base_url   = fetch_config(:base_url)
          @key        = fetch_config(:key)
          @salt       = fetch_config(:salt)
          @aws_bucket = fetch_config(:aws_bucket)
        end

        private

        def fetch_config(key)
          check_config!

          value = imgproxy_config[key.to_s]
          return ENV[value.gsub(/^ENV_/, '')] if value&.match?(/^ENV_/)

          value
        end

        def check_config!
          raise Jekyll::Imgproxy::Tag::Errors::ConfigNotFound if imgproxy_config.nil?
          raise Jekyll::Imgproxy::Tag::Errors::SaltNotSet if imgproxy_config['salt'].nil?
          raise Jekyll::Imgproxy::Tag::Errors::KeyNotSet if imgproxy_config['key'].nil?
          raise Jekyll::Imgproxy::Tag::Errors::BaseUrlNotSet if imgproxy_config['base_url'].nil?
        end

        def imgproxy_config
          Jekyll.configuration['imgproxy']
        end
      end
    end
  end
end
