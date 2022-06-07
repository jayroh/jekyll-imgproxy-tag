# frozen_string_literal: true

module Jekyll
  module Imgproxy
    class Tag
      class Error < StandardError
      end

      module Errors
        class ConfigNotFound < Error
          def message
            'imgproxy namespace not found in Jekyll configuration'
          end
        end

        class SaltNotSet < Error
          '"salt" is not set in Jekyll imgproxy config'
        end

        class KeyNotSet < Error
          '"key" is not set in Jekyll imgproxy config'
        end

        class BaseUrlNotSet < Error
          '"base_url" not set in Jekyll Imgproxy config'
        end
      end
    end
  end
end
