require 'thor'

module MetaWordpress
  class CLI < Thor
    require 'meta_wordpress'

    desc "bootstrap", "Create initial set of files and folders"
    def bootstrap
      puts "I'm a thor task!"
    end

  end
end
