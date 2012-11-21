require 'rubygems'
require 'bundler'
Bundler.setup

require 'rspec'

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'meta_wordpress'

RSpec.configure do |config|
  config.order = 'random'
end
