# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'diy_api/version'

Gem::Specification.new do |gem|
  gem.add_dependency "faraday"
  gem.add_dependency "faraday_middleware"
  gem.add_dependency "rash"
  gem.name          = "diy_api"
  gem.version       = DiyApi::VERSION
  gem.authors       = ["Diana Kimball"]
  gem.email         = ["diana.kimball@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
