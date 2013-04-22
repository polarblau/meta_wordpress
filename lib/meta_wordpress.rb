require File.expand_path('guard/reload_meta_wordpress.rb', File.dirname(__FILE__))

require 'haml'

require File.expand_path('haml/filters/docs', File.dirname(__FILE__))
require File.expand_path('haml/filters/php', File.dirname(__FILE__))

require File.expand_path('haml/helpers/php_helpers', File.dirname(__FILE__))
require File.expand_path('haml/helpers/html_helpers', File.dirname(__FILE__))
require File.expand_path('haml/helpers/layout_helpers', File.dirname(__FILE__))

load File.expand_path('haml/helpers/user_view_helpers.rb', File.dirname(__FILE__))