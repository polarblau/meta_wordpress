# Meta Wordpress

**This gem has not been released yet and is NOT production ready. (I don’t mind feedback, though).**

Use Haml, Sass, Coffeescript and Ruby to build wordpress views. All your files are compiled when changed using Guard.

## Usage

Install the gem:

```bash
gem install meta_wordpress
```

Bootstrap a new theme:

```bash
cd http/wp-content/themes/
wp bootstrap my_theme
cd my_theme
```

Add Haml files in th e`views/` directory with the extension `.php.haml` will be compiled into the theme root.
Sass files in the `stylesheets/source/` directory will be compiled into `stylesheets/compiled/` 
and Coffeescript files from `javascripts/source/` to javascripts/compiled`.

For convenience you can start Guard in a Bundler context using 

```bash
wp start
```

## Helpers

The gem includes currently some filters (more to be added if helpful)
and *you can add you own* in  `view_helpers.rb`. Ensure to restart Guard after every change.

### `php`

```haml
%1
  = php "echo $headline"
```
compiles to 

```html
<h1><?php echo $headline ?></h1>
```

## Filters

A few filters are packaged as well

### `php`

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

### `docs`

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