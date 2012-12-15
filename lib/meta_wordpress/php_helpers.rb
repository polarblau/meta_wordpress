module MetaWordpress
  module PHPHelpers

    def layout(layout_name)
      php "use_layout('#{layout_name}')"
    end

    def partial(partial_name)
      php "render_partial('#{partial_name}')"
    end

    def yield_content
      php "yield()"
    end

  end
end
