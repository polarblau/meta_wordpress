module MetaWordpress
  module PHPHelpers

    METHODS = {
      :layout        => "use_layout('[*]')",
      :partial       => "render_partial('[*]')",
      :yield_content => "yield()"
    }

    METHODS.each do |method, php_value|
      define_method(method) do |*args|
        php php_value.gsub('[*]', convert_arguments(args).join(', '))
      end
    end

  private

    def convert_arguments(arguments)
      arguments.map do |argument|
        argument.is_a?(Symbol) ? "$#{argument}" : argument.to_s
      end
    end

  end
end
