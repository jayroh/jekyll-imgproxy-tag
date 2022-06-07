# frozen_string_literal: true

require 'openssl'
require 'base64'

module Jekyll
  module Imgproxy
    class Tag
      class HmacBuilder
        def initialize(config, path)
          @config = config
          @path = path
        end

        def build
          digest      = OpenSSL::Digest.new('sha256')
          hmac_digest = OpenSSL::HMAC.digest(digest, key, "#{salt}#{path}")
          Base64.urlsafe_encode64(hmac_digest).tr('=', '')
        end

        protected

        attr_reader :config, :path

        private

        def key
          [config.key].pack("H*")
        end

        def salt
          [config.salt].pack("H*")
        end
      end
    end
  end
end
