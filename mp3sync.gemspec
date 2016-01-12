# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mp3sync/version'

Gem::Specification.new do |spec|
  spec.name          = 'mp3sync'
  spec.version       = Mp3Sync::VERSION
  spec.authors       = ['chrismo']
  spec.email         = ['chrismo@clabs.org']

  spec.summary       = %q{Gem to handle mp3 playlist creation and device syncing}
  spec.homepage      = 'https://github.com/chrismo/mp3sync'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'boson', '~> 1.3'
  spec.add_dependency 'boson-more', '~> 0.3'
  spec.add_dependency 'text-table'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
end
