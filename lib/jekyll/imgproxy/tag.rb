# frozen_string_literal: true

module Jekyll
  module Imgproxy
    class Tag < ::Liquid::Tag
      VERSION = '0.1.0'

      def initialize(tag_name, raw_options, tokens)
        super
        @raw_options = raw_options
        @options = {}

        @raw_options.scan(::Liquid::TagAttributes) do |key, value|
          @options[key] = value.gsub(/^['"]|['"]$/, '')
        end
      end

      def render(_context)
        imgproxy_config = ImgproxyConfig.new
        UrlGenerator.new(imgproxy_config, options).url
      end

      protected

      attr_accessor :options
    end
  end
end

Liquid::Template.register_tag('imgproxy_url', Jekyll::Imgproxy::Tag)
