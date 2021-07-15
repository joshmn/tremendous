# frozen_string_literal: true

require_relative 'lib/tremendous/version'

Gem::Specification.new do |spec|
  spec.name          = 'tremendous'
  spec.version       = Tremendous::VERSION
  spec.authors       = ['Josh Brody']
  spec.email         = ['git@josh.mn']

  spec.summary       = 'Tremendous.com API client.'
  spec.description   = spec.description
  spec.homepage      = 'https://github.com/joshmn/tremendous'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/joshmn/tremendous'

  spec.files = Dir['{lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.require_paths = ['lib']
end
