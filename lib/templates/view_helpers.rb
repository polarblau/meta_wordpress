module ViewHelpers

  # Define your own helpers here!
  #
  # NOTE: You will need to restart Guard after any changes to this file.
  #
  # Here are some examples to get you started.
  # These shortcuts are also used in the included theme,
  # so don't remove them if you want to use this theme as is.
  
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
