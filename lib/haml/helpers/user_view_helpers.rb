user_view_helpers = File.expand_path('view_helpers.rb', Dir.getwd)
load user_view_helpers if File.exists?(user_view_helpers)

module Haml
  module Helpers
    include ViewHelpers if defined?(ViewHelpers)
  end
end
