## Documentation

*meta_wordpress* comes with an executable that allows you to bootstrap a new theme and start a file system watcher using Guard.

**[Documentation for the executable](executable.md)**

Since Wordpress’ approach to partial views doesn’t work very well with HAML’s self–closing tags, *meta_wordpress* provides a small layout engine, supporting partials, layouts and content_for assignments.

**[Documentation for the layout rendering](layout.md)**

As the PHP implementation of Haml was deemed a bad fit and seems unmaintained, *meta_wordpress* runs entirely on Ruby. Hence some helpers for the PHP generation and other uses are included.

**[Documentation for helpers](helpers.md)**