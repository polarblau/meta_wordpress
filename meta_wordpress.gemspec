# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'meta_wordpress/version'

Gem::Specification.new do |s|
  s.name          = "meta_wordpress"
  s.version       = MetaWordpress::VERSION
  s.authors       = ["Florian Plank"]
  s.email         = ["florian@polarblau.com"]
  s.homepage      = "https://github.com/polarblau/meta_wordpress"
  s.summary       = "Work on WP with your favorite meta languages"
  s.summary       = "Helpers for the work with Wordpress using meta languages such as HAML, SASS and Coffeescript."

  s.files         = `git ls-files -- lib/*`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.rubyforge_project = '[none]'
  s.executable   = 'meta_wordpress'

  # Dependencies
  # (There's a lot of them, because this gem is merely a collector at this point)
  s.add_runtime_dependency 'haml',        '>= 0'

  s.add_dependency 'bundler'
  s.add_dependency 'thor',                '>= 0.14.6'
  s.add_dependency 'active_support',      '~> 3.0.0'

  s.add_dependency 'guard',               '~> 1.8.0'
  s.add_dependency 'rb-fsevent',          '~> 0.9.1'

  s.add_dependency 'guard-haml-ext',      '~> 0.6.0'
  s.add_dependency 'guard-sass',          '~> 1.0.5'
  s.add_dependency 'guard-coffeescript',  '~> 1.3.0'

  # Dev dependencies
  s.add_development_dependency 'rspec',   '~> 2.11.0'
end
