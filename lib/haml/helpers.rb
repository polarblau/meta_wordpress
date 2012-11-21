module Haml
  module Helpers

    # include user helpers if defined ...

    def php(text)
      if text.include? "\n"
        "<?php\n  %s\n?>" % text.rstrip.gsub("\n", "\n  ")
      else
        "<?php %s ?>" % text.strip
      end
    end

  end
end
