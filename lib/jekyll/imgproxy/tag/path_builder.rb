# frozen_string_literal: true

require 'base64'

module Jekyll
  module Imgproxy
    class Tag
      class PathBuilder
        def initialize(config, options)
          @config = config
          @options = options
          @path = @options.delete('path')

          @resizing_type = 'rs:fit'
          @width = ':'
          @height = ':'
          @format = '.jpg'
        end

        def build
          options.each { |key, value| send("#{key}=".to_sym, value) }

          "/#{resizing_type}#{width}#{height}#{gravity}#{quality}#{max_bytes}#{cache_buster}/#{encoded_url}#{format}"
        end

        protected

        attr_reader \
          :config,
          :options,
          :path,
          :resizing_type,
          :width,
          :height,
          :gravity,
          :quality,
          :max_bytes,
          :cache_buster,
          :format

        private

        def encoded_url
          Base64
            .urlsafe_encode64(s3_url)
            .tr('=', '')
            .scan(/.{1,16}/)
            .join('/')
        end

        def s3_url
          "s3://#{config.aws_bucket}#{path}"
        end

        def resizing_type=(resizing_type)
          @resizing_type = "rs:#{resizing_type}"
        end

        def format=(format)
          @format = ".#{format}"
        end

        def width=(width)
          @width = ":#{width}"
        end

        def height=(height)
          @height = ":#{height}"
        end

        def gravity=(gravity)
          @gravity = "/g:#{gravity}"
        end

        def quality=(quality)
          @quality = "/q:#{quality}"
        end

        def max_bytes=(max_bytes)
          @max_bytes = "/mb:#{max_bytes}"
        end

        def cache_buster=(cache_buster)
          @cache_buster = "/cb:#{cache_buster}"
        end
      end
    end
  end
end
