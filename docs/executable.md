## Executable

### Bootstrapping

```bash
meta_wordpress bootstrap [THEME_NAME]
```

This generator will ask you a bunch of questions and generate a the necessary files and folders accordingly to get you started. If you don’t supply a THEME_NAME the name of the current folder will be used instead.

#### Overview over the generated files

Currently the *meta_wordpress* generates the following structure within  the theme folder. Files marked with an asterisk (*) are part of the bootstrap theme and can be skipped.

```
THEME_FOLDER
|-- functions.php
|-- Gemfile
|-- Gemfile.lock
|-- Guardfile
|-- javascripts
|    |-- compiled
|    +-- source  
|         +-- modernizr-2.6.2.min*
|-- lib
|    +-- meta_wordpress
|         |-- layout.class.php
|         +-- wordpress_layout.php
|    +-- meta_wordpress.php  
|-- README.md
|-- screenshot.png
|-- style.css
|-- stylesheets
|    |-- compiled
|    +-- source  
|         |-- screen.sass*
|         +--vendor*
|              +-- normalize.scss*
|-- view_helpers.rb
+-- views
     |-- index.php.haml*
     +-- layouts
          +--default.php.haml*
     +-- partials
          |-- _footer.php.haml*
          +-- _header.php.haml*
     +-- single.php.haml*
```

###### functions.php 

Is the default location to configure and extend Wordpress with custom PHP code. It is also used to load the *meta_wordpress* layout engine.

###### Gemfile

Is used by [Bundler](http://gembundler.com) and allows you specify which Ruby gems your project depends on. This is a good place to specify e.g. Sass libraries which come bundled as gems, like [Compass](http://compass-style.org/) or [Bourbon](http://bourbon.io/). [Learn more about how to use the Gemfile](http://gembundler.com/v1.3/gemfile.html).

###### Guardfile

Holds all guards supplied by *meta_wordpress* and defines how and when Haml, Sass and Coffeescript files are compiled. Add your own Guards here or modify the *meta_wordpress* default behavior. [Learn more about Guard](https://github.com/guard/guard/wiki/Guardfile-examples).

###### javascripts/

Stores `.coffee` files in the `/source` directory and they will be compiled to `.js` files for you into the `/compiled` folder. Keep all (vendored) `.js` files in the `compiled directory to begin with.

###### lib/

Contains *meta_wordpress* layout engine and is a good place to store Wordpress filters etc..

###### README.md

Contains some basic information on *meta_wordpress* and how to get started. Edit this file if you want to share information on development practices with your team.

###### screenshot.png

Is a dummy thumbnail for your theme — customize as you see fit.

###### style.css

Contains the theme meta data and is required by Wordpress. It will be populated for you based on the answers you give when running the bootstrap generator.

###### stylesheets/

Stores `.sass/.scss` files in the `/source` directory and they will be compiled to `.css` files for you into the `/compiled` folder. Keep all (vendored) `.css` files in the `compiled directory to begin with.

###### view_helpers.rb

Allows you to specify your own Haml helpers using Ruby.

###### views/

Contains the Haml files which will be compiled to  `.php` files in the root of the theme folder. View files must end in `.php.haml` to ensure proper compilation.

By default partial views are expected to reside in the `/partials` folder  and partial file names must begin with an underscore (_).
Layouts — the “frame” for each view — are kept in the `layouts folder`, a default layout with the name `default.php.haml` is expected. 
All of these defaults are [configurable](layout.md), though.

#### Skipping the theme files

When bootstrapping *meta_wordpress* will also generate a few theme files for you, such as templates for index and single views. If you want to skip the creation of these files, pass `--skip-theme` when running the bootstrap task.

```bash
meta_wordpress bootstrap [THEME_NAME] --skip-theme
```

### Starting the file watcher (Guard)

```bash
meta_wordpress start
```

This will start Guard with a bit of configuration in a bundler context (using `bundle exec`) to ensure that *meta_wordpress* is available. 

Guard will watch for changes to files in the theme directory and compile or reload them as needed.

Depending on how you have installed meta_wordpress, you can also run Guard the way you’re used to.