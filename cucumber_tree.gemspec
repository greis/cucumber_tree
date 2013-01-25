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

  gem.add_runtime_dependency 'cucumber-rails', '>= 1.3.0'
  gem.add_runtime_dependency 'rspec', '>= 2.9.0'

  gem.add_development_dependency 'aruba', '>= 0.5.0'
  gem.add_development_dependency 'bundler', '>= 1.1.0'
  gem.add_development_dependency 'rails', '>= 3.2.8'
  gem.add_development_dependency 'sqlite3', '>= 1.3.6'
  gem.add_development_dependency 'pg', '>= 0.14.1'

  # Dependencies that Rails puts inside apps.
  gem.add_development_dependency 'sass-rails', '>= 3.2.5'
  gem.add_development_dependency 'coffee-rails', '>= 3.2.2'
  gem.add_development_dependency 'uglifier', '>= 1.2.4'
  gem.add_development_dependency 'jquery-rails', '>= 2.0.2'
end
