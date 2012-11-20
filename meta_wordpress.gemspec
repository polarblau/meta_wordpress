# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'meta_wordpress/version'

Gem::Specification.new do |s|
  s.name          = "meta_wordpress"
  s.version       = MetaWordpress::VERSION
  s.authors       = ["Florian Plank"]
  s.email         = ["polarblau@gmail.com"]
  s.homepage      = "https://github.com/polarblau/meta_wordpress"
  s.summary       = "Helpers for work with Wordpress using meta languages such as HAML."

  s.files         = `git ls-files app lib`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.rubyforge_project = '[none]'
  s.add_dependency 'haml', '~> 3.1.7'
end
