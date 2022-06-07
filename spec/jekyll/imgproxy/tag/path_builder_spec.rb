# frozen_string_literal: true

require 'jekyll/imgproxy/tag/path_builder'

module Jekyll
  module Imgproxy
    class Tag
      describe PathBuilder do
        let(:config) do
          OpenStruct.new.tap do |cfg|
            cfg.aws_bucket = "my-bucket"
          end
        end

        def stub_builder(builder)
          allow(builder).to receive(:encoded_url).and_return('encoded-url')
        end

        it 'converts to another format' do
          options = { 'path' => '/img.jpg', 'width' => 300, 'format' => 'avif' }
          builder = described_class.new(config, options)
          stub_builder(builder)

          expect(builder.build).to eq '/rs:fit:300:/encoded-url.avif'
        end

        it 'adds a width' do
          options = { 'path' => '/img.jpg', 'width' => 300 }
          builder = described_class.new(config, options)
          stub_builder(builder)

          expect(builder.build).to eq '/rs:fit:300:/encoded-url.jpg'
        end

        it 'adds a height' do
          options = { 'path' => '/img.jpg', 'height' => 300 }
          builder = described_class.new(config, options)
          stub_builder(builder)

          expect(builder.build).to eq '/rs:fit::300/encoded-url.jpg'
        end

        it 'adds width and height' do
          options = { 'path' => '/img.jpg', 'width' => 200, 'height' => 300 }
          builder = described_class.new(config, options)
          stub_builder(builder)

          expect(builder.build).to eq '/rs:fit:200:300/encoded-url.jpg'
        end

        # https://docs.imgproxy.net/generating_the_url?id=resizing-type
        it 'adds a resizing type' do
          options = { 'path' => '/img.jpg', 'resizing_type' => 'fill', 'width' => 200, 'height' => 300 }
          builder = described_class.new(config, options)
          stub_builder(builder)

          expect(builder.build).to eq '/rs:fill:200:300/encoded-url.jpg'
        end

        # https://docs.imgproxy.net/generating_the_url?id=gravity
        it 'adds a gravity option' do
          options = { 'path' => '/img.jpg', 'gravity' => 'sm', 'width' => 200, 'height' => 300 }
          builder = described_class.new(config, options)
          stub_builder(builder)

          expect(builder.build).to eq '/rs:fit:200:300/g:sm/encoded-url.jpg'
        end

        # https://docs.imgproxy.net/generating_the_url?id=quality
        it 'adds a quality option' do
          options = { 'path' => '/img.jpg', 'quality' => 85, 'width' => 200, 'height' => 300 }
          builder = described_class.new(config, options)
          stub_builder(builder)

          expect(builder.build).to eq '/rs:fit:200:300/q:85/encoded-url.jpg'
        end

        # https://docs.imgproxy.net/generating_the_url?id=max-bytes
        it 'adds a max bytes option' do
          options = { 'path' => '/img.jpg', 'max_bytes' => 1024, 'width' => 200, 'height' => 300 }
          builder = described_class.new(config, options)
          stub_builder(builder)

          expect(builder.build).to eq '/rs:fit:200:300/mb:1024/encoded-url.jpg'
        end

        # https://docs.imgproxy.net/generating_the_url?id=cache-buster
        it 'adds a cache-buster option' do
          options = { 'path' => '/img.jpg', 'cache_buster' => 'BUSTA', 'width' => 200, 'height' => 300 }
          builder = described_class.new(config, options)
          stub_builder(builder)

          expect(builder.build).to eq '/rs:fit:200:300/cb:BUSTA/encoded-url.jpg'
        end
      end
    end
  end
end
