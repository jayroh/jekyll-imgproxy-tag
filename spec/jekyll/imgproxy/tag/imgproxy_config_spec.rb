# frozen_string_literal: true

module Jekyll
  module Imgproxy
    class Tag
      describe ImgproxyConfig do
        def stub_config_with(values)
          config_hash = values.instance_of?(String) ? yaml(values) : values

          allow(Jekyll)
            .to receive(:configuration)
            .and_return(config_hash)
        end

        def yaml(filename)
          path = "./spec/fixtures/configs/#{filename}"
          YAML.load_file(path)
        end

        it 'reads the yaml' do
          stub_config_with('_config.yml')
          config = described_class.new

          expect(config.base_url).to eq 'https://imgproxy.instance'
          expect(config.key).to eq 'key'
          expect(config.salt).to eq 'salt'
          expect(config.aws_bucket).to eq 'bucket-name'
        end

        it 'raises an error if the parent imgproxy key is not set' do
          stub_config_with({})

          expect { described_class.new }
            .to raise_error(Jekyll::Imgproxy::Tag::Errors::ConfigNotFound)
        end

        it 'raises an error if the salt is not set' do
          stub_config_with({'imgproxy' => { 'salt' => nil }})

          expect { described_class.new }
            .to raise_error(Jekyll::Imgproxy::Tag::Errors::SaltNotSet)
        end

        it 'raises an error if the key is not set' do
          stub_config_with({'imgproxy' => { 'salt' => '', 'key' => nil }})

          expect { described_class.new }
            .to raise_error(Jekyll::Imgproxy::Tag::Errors::KeyNotSet)
        end

        it 'raises an error if the base_url is not set' do
          stub_config_with(
            {
              'imgproxy' => {
                'salt' => 'salt here',
                'key' => 'key here',
                'base_url' => nil
              }
            }
          )

          expect { described_class.new }
            .to raise_error(Jekyll::Imgproxy::Tag::Errors::BaseUrlNotSet)
        end
      end
    end
  end
end
