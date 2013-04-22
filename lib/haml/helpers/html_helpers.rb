module Haml
  module Helpers

    def javascript_include_tag(*files)
      capture_haml do
        files.each do |file|
          file = file.dup + ".js" if File.extname(file) != '.js'
          haml_tag :script, :type => "text/javascript", :src => asset_path(file)
        end
      end
    end

    def stylesheet_link_tag(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      capture_haml do
        args.map(&:to_s).each do |file|
          file = file.dup + ".css" if File.extname(file) != '.css'
          haml_tag :link, {
            :href => asset_path(file), :media => "screen", :rel => "stylesheet", :type => "text/css"
          }.merge(options)
        end
      end
    end

    def asset_path(file_name)
      return file_name if file_name =~ /^[http|\/\/]/
      group = case File.extname(file_name)
      when ".js"
        File.join "javascripts", "compiled"
      when ".css"
        File.join "stylesheets", "compiled"
      when ".png", ".jpg", ".jpeg", ".gif", ".svg"
        "images"
      else
        raise(ArgumentError, "unknown file extension: '#{File.extname(file_name)}'")
      end
      relative_path = File.join(group, file_name)
      "#{ php_e("get_bloginfo('stylesheet_directory')") }/#{relative_path}"
    end

    def conditionals_html(attrs={}, &block)
      attrs.keys.each do |key|
        attrs[(key.to_sym rescue key) || key] = attrs.delete(key)
      end
      haml_concat("<!--[if lt IE 7]>#{ tag(:html, add_class('ie6', attrs), true) }<![endif]-->")
      haml_concat("<!--[if IE 7]>#{ tag(:html, add_class('ie7', attrs), true) }<![endif]-->")
      haml_concat("<!--[if IE 8]>#{ tag(:html, add_class('ie8', attrs), true) }<![endif]-->")
      haml_concat("<!--[if gt IE 8]><!-->")
      haml_tag :html, attrs do
        haml_concat("<!--<![endif]-->")
        block.call
      end
    end

  private

    def add_class(name, attrs)
      classes = attrs[:class] || ''
      classes.strip!
      classes = ' ' + classes if !classes.empty?
      classes = name + classes
      attrs.merge(:class => classes)
    end

    def tag_attributes(attrs={})
      attrs.map {|k, v| "#{k}=\"#{v}\"" }.join(' ')
    end

    def tag(name, attrs=nil, open=false)
      "<#{name}#{" #{tag_attributes(attrs)}" if attrs}#{open ? ">" : " />"}"
    end

  end
end
