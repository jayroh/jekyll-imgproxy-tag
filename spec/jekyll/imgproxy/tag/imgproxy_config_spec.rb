# frozen_string_literal: true

module Jekyll
  module Imgproxy
    class Tag
      describe ImgproxyConfig do
        it 'reads the yaml' do
          context = {
            'site' => {
              'imgproxy' => {
                'base_url' => 'https://imgproxy.instance',
                'key' => 'key',
                'salt' => 'salt',
                'aws_bucket' => 'bucket-name',
              }
            }
          }
          config = described_class.new(context)

          expect(config.base_url).to eq 'https://imgproxy.instance'
          expect(config.key).to eq 'key'
          expect(config.salt).to eq 'salt'
          expect(config.aws_bucket).to eq 'bucket-name'
        end

        it 'raises an error if the parent imgproxy key is not set' do
          context = {
            'site' => {}
          }

          expect { described_class.new(context) }
            .to raise_error(Jekyll::Imgproxy::Tag::Errors::ConfigNotFound)
        end

        it 'raises an error if the salt is not set' do
          context = {
            'site' => {
              'imgproxy' => {
                'base_url' => 'https://imgproxy.instance',
                'key' => 'key',
                'salt' => nil,
                'aws_bucket' => 'bucket-name',
              }
            }
          }

          expect { described_class.new(context) }
            .to raise_error(Jekyll::Imgproxy::Tag::Errors::SaltNotSet)
        end

        it 'raises an error if the key is not set' do
          context = {
            'site' => {
              'imgproxy' => {
                'base_url' => 'https://imgproxy.instance',
                'key' => nil,
                'salt' => 'salt',
                'aws_bucket' => 'bucket-name',
              }
            }
          }

          expect { described_class.new(context) }
            .to raise_error(Jekyll::Imgproxy::Tag::Errors::KeyNotSet)
        end

        it 'raises an error if the base_url is not set' do
          context = {
            'site' => {
              'imgproxy' => {
                'base_url' => nil,
                'key' => 'key',
                'salt' => 'salt',
                'aws_bucket' => 'bucket-name',
              }
            }
          }

          expect { described_class.new(context) }
            .to raise_error(Jekyll::Imgproxy::Tag::Errors::BaseUrlNotSet)
        end
      end
    end
  end
end
