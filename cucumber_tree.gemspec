# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cucumber_tree/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Gabriel Reis"]
  gem.email         = ["gabriel.oreis@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cucumber_tree"
  gem.require_paths = ["lib"]
  gem.version       = CucumberTree::VERSION

  gem.add_runtime_dependency('cucumber-rails', '>= 1.3.0')
  gem.add_runtime_dependency('yaml_db', '>= 0.2.3')
end
