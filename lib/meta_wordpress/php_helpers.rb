module MetaWordpress
  module PHPHelpers

    METHODS = {
      :layout        => "use_layout('[*]')",
      :partial       => "render_partial('[*]')",
      :yield_content => "yield()"
    }

    METHODS.each do |method, php_value|
      define_method(method) do |*args|
        php php_value.gsub('[*]', coerce_arguments(args).join(', '))
      end
    end

    def php_if(condition, &block)
      html = []
      html << php("if (#{condition}):")
      html << "  " + capture_haml do
        yield if block_given?
      end
      html.join("\n").gsub(/(\\n)+/, "\n")
    end

    def php_else(condition, &block)
      s = []
      s << php("else:")
      s << "  " + capture_haml do
        yield if block_given?
      end
      s.join("\n").gsub("\n\n", "\n")
    end

  private

    def coerce_arguments(arguments)
      arguments.map do |argument|
        argument.is_a?(Symbol) ? "$#{argument}" : argument.to_s
      end
    end

  end
end
