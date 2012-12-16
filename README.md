# Meta Wordpress

**This gem has not been released yet and is NOT production ready. (I wouldn’t mind feedback, though).**

*TL;DR* — Use Haml, Sass, Coffeescript (and Ruby :open_mouth:) to build Wordpress themes. 

***

Building sites with Wordpress is often painful (PHP) enough. Using our favorite tools from the Ruby world such as Haml, Sass and Coffeescript would certainly help.
Unfortunately the current PHP implementations of Haml can’t be really recommended for different reasons. The biggest problem seems to be a lot of added complexity — which ways in immediately when things go wrong.

This gem lets you use the original implementations of all your favorite meta languages and compiles the files in the most transparent way — keeping both source and result around for inspection. The compilation is done using Guard and *meta_wordpress* simply provides a few helpers to get you started. 

## Usage

### Installation

Install the gem:

```bash
gem install meta_wordpress
```

Then bootstrap a new theme — this will generate all necessary files for your:

```bash
# navigate to the themes folder
cd http/wp-content/themes/
# bootstrap
wp bootstrap my_theme
# navigate to your new theme
cd my_theme
```

*HINT*: If you don’t provide a name for your theme, the current folder will be used.

### Building a theme

* **Haml files** in the `views/` directory with the extension `.php.haml` will be compiled into the theme root.
* **Sass files** in the `stylesheets/source/` directory will be compiled into `stylesheets/compiled/` 
* **Coffeescript files** from `javascripts/source/` to `javascripts/compiled`.

Guard is used to watch for changes and recompile files when necessary. For convenience you can start Guard in a Bundler context using:

```bash
wp start
```

#### Helpers

The gem includes currently some helpers (more to be added if helpful) and *you can add you own* in `view_helpers.rb`. Ensure to restart Guard after every change.

##### `php`

```haml
%1
  = php "echo $headline"
```
compiles to 

```html
<h1><?php echo $headline ?></h1>
```

The `php` helper takes a block as second argument to allow for better readability through indentation:

```haml
#primary
  #content(role="main")
    = php "if (have_posts()):" do
      = php "while (have_posts()):" do
        = php "the_post()"
        %h2= php "the_title()"
      = php "endwhile"
    = php "endif"
```

#### Filters

A few filters are packaged as well

##### `php`

```haml
:php
  $headline = "foo";
  echo $headline;
```
compiles to 

```html
<?php 
  $headline = "foo"
  echo $headline;
?>
```

##### `docs`

```haml
:docs
  The Template for displaying all single posts.

  @package WordPress
  @subpackage Twenty_Eleven
  @since Twenty Eleven 1.0
```
compiles to 

```html
<?php
/**
 * The Template for displaying all single posts.
 *
 * @package WordPress
 * @subpackage Twenty_Eleven
 * @since Twenty Eleven 1.0
 */
?>
```

#### View structure

Since Haml closes all HTML tags for you, you can’t easily split tags across view files as it is standard practice with most Wordpress themes (just think of the `<body>` tag starting in `header.php` and ending in `footer.php`). 
To be able to build a theme “the Haml way”, you will need to think of your theme in a slightly different way — if you're coming from frameworks like Rails, this will look familiar to you.

```

   +---------------------------------------------------------------+
   | /views/layout/default.php.haml                                |
   +---------------------------------------------------------------+
   | +----------------------------------------------------------+  |
   | | /views/partials/_header.php.haml                         |  |
   | |----------------------------------------------------------|  |
   | |                                                          |  |
   | |  = php "render_partial('header')"                        |  |
   | |                                                          |  |
   | +----------------------------------------------------------+  |
   | +----------------------------------------------------------+  |
   | | /views/single.php.haml                                   |  |
   | |----------------------------------------------------------|  |
   | |                                                          |  |
   | |  = php "yield_content()"                                 |  |
   | |                                                          |  |
   | +----------------------------------------------------------+  |
   | +----------------------------------------------------------+  |
   | | /views/partials/_footer.php.haml                         |  |
   | |----------------------------------------------------------|  |
   | |                                                          |  |
   | |  = php "render_partial('footer')"                        |  |
   | |                                                          |  |
   | +----------------------------------------------------------+  |
   +---------------------------------------------------------------+
   
```

##### Layouts

meta_wordpress requires you to wrap your templates (such as `index` or `single`) into a layout file. Layout files are stored in the `/views/layouts` folder. 

If no layout file is defined specifically, a file `/views/layouts/default.php.haml`  is expected.
You can specify a different layout at the top your template, using the PHP function `use_layout()` passing the name of a layout file — e.g.:

*/views/index.php.haml*

```haml
= php "use_layout('foobar')"
``` 

Within your layout you need to make a call to the PHP function `yield_content()` at the location where you want to render your actual template — e.g.:

*/views/layouts/default.php.haml*

```haml
%header My layout header

= php "yield_content()"

%footer My layout footer
```

##### Partials

`meta_wordpress` also provides a PHP helper for partials views. Partials are expected in the `/views/partials/` folder and must have a filename beginning with an underscore.

Within your template or layout you can render a partial using the PHP function `render_partial()` and pass the name of a partial — e.g.:

*/views/layouts/default.php.haml*

```haml
%header
  -# Renders `/views/partials/_header.php.haml`
  = php "render_partial('header')"
```

*HINT: If you’re feeling adventurous you can include the `MetaWordpress::PHPHelpers` module into the view helpers.*

```ruby
require 'meta_wordpress/php_helpers'

module ViewHelpers
  include MetaWordpress::PHPHelpers
end
```

This includes the following shorcuts to PHP function calls:

```ruby
layout(NAME) 
# => <?php use_layout(NAME) ?>

partial(NAME) 
# => <?php render_partial(NAME) ?>

yield_content
# => <?php yield() ?>
```

**Argument conversion!** — Symbols are converted to PHP variables for convenience:

```ruby
layout(:foo, "bar", 1, true)
# => <?php use_layout($foo, "bar", 1, true) ?>
```

## TODO

* Compile all views when installing
* Clean installation logs and add some help texts
* Better error handling and display
* Add full Haml version of a basic theme when bootstrapping
