# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'yaml'
require 'rspec'
require 'jekyll'
require 'pry'
require_relative '../lib/jekyll-imgproxy-tag'

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end
