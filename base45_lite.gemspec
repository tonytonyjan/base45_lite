# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = 'base45_lite'
  spec.version = '1.0.0'
  spec.authors = ['Weihang Jian']
  spec.email = ['tonytonyjan@gmail.com']
  spec.summary = 'Base45 encoder/decoder'
  spec.description = 'Base45 encoder/decoder'
  spec.homepage = 'https://github.com/tonytonyjan/base45_lite'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'
  spec.files = Dir['lib/**/*.rb']
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
