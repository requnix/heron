# -*- encoding: utf-8 -*-
require File.expand_path('../lib/heron/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Michael Prins']
  gem.email         = ['michael.prins@me.com']
  gem.description   = %q{Heron is a media library management tool that leaves as much info as it can whilst leaving the fewest files possible.}
  gem.summary       = %q{Heron sorts your media files and picks away all the cruft.}
  gem.homepage      = 'https://github.com/requnix/heron'
  
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'heron'
  gem.require_paths = ['lib']
  gem.version       = Heron::VERSION
  
  gem.add_runtime_dependency 'thor'
  
  gem.add_development_dependency 'rake'
end
