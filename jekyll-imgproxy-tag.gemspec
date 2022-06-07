# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll-imgproxy-tag'

Gem::Specification.new do |spec|
  spec.name          = 'jekyll-imgproxy-tag'
  spec.version       = Jekyll::Imgproxy::Tag::VERSION
  spec.authors       = ['Joel Oliveira']
  spec.email         = ['joel@jayroh.com']

  spec.summary       = 'jekyll plugin to generate urls to secure imgproxy images'
  spec.description   = 'jekyll plugin to generate urls to secure imgproxy images'
  spec.homepage      = 'https://github.com/jayroh/jekyll-imgproxy-tag'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.7.0'

  spec.add_dependency 'jekyll'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubygems-tasks', '~> 0.2'
end
