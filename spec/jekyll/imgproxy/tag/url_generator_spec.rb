# frozen_string_literal: true

module Jekyll
  module Imgproxy
    class Tag
      describe UrlGenerator do
        it 'generates a url' do
          path_builder = instance_double('PathBuilder')
          hmac_builder = instance_double('HmacBuilder')
          allow(path_builder).to receive(:build).and_return('/generated-path')
          allow(hmac_builder).to receive(:build).and_return('hmac')
          allow(PathBuilder).to receive(:new).and_return(path_builder)
          allow(HmacBuilder).to receive(:new).and_return(hmac_builder)

          config = OpenStruct.new(base_url: 'https://img.dev')
          options = {}

          url_generator = described_class.new(config, options)

          expect(url_generator.url).to eq 'https://img.dev/hmac/generated-path'
        end
      end
    end
  end
end
