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
  s.add_dependency 'thor',                '>= 0.14.6'

  s.add_dependency 'guard',               '~> 1.5.4'
  s.add_dependency 'rb-fsevent',          '~> 0.9.1'

  s.add_dependency 'haml',                '~> 3.1.7'
  # s.add_dependency 'guard-haml' -- currently misses my extension detection -> Gemfile

  s.add_dependency 'sass',                '~> 3.2'
  s.add_dependency 'guard-sass',          '~> 1.0.1'

  s.add_dependency 'coffee-script',       '~> 2.2.0'
  s.add_dependency 'guard-coffeescript',  '~> 1.2.1'

  # Dev dependencies
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rspec',       '~> 2.11.0'
end
