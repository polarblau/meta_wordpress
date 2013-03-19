require 'rspec/expectations'

RSpec::Matchers.define :have_been_created_in do |path|
  match do |file|
    File.exists?(File.join(path, file))
  end
end