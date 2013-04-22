module Haml
  module Helpers

    def layout(layout_name)
      php "use_layout('#{layout_name}')"
    end

    def partial(partial_name, locals={})
      locals = locals.empty? ? "" : ", #{convert_php_arguments(locals)}"
      php "render_partial('#{partial_name}'#{locals})"
    end

    def yield_content(name = nil)
      php "yield(#{ "'#{name}'" if name })"
    end

    def content_for(name, *args, &block)
      options = args.last.is_a?(::Hash) ? args.pop : {}
      content = args.first.is_a?(::String) ? args.shift : ''
      locals  = if (vars = options[:use]) && !vars.empty?
        "use(#{[vars].flatten.join(", ")}) "
      else
        ""
      end
      haml_concat php("content_for('#{name}', function() #{locals}{")
      captured_content = if block_given?
        capture_haml do
          yield
        end
      else
        content
      end
      haml_concat captured_content.strip
      haml_concat php("})")
    end

  end
end
