<%- unless @skip_theme -%>
require 'meta_wordpress/php_helpers'

<%- end -%>
module ViewHelpers
  <%- if @skip_theme -%>
  # If you’re feeling adventurous, you can include
  # the PHP helpers module — check the docs for details:
  #
  # include MetaWordpress::PHPHelpers
  #
  # Don't forget to require the necessary file above
  # using `require 'meta_wordpress/php_helpers'`
  require 'meta_wordpress/php_helpers'
  <%- else -%>
  include MetaWordpress::PHPHelpers
  <%- end -%>

  # Define your own helpers here!

end