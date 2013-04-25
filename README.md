## Meta Wordpress

*meta_wordpress* is a small library built around [Guard](https://github.com/guard/guard) which enables you to create Wordpress themes more easily, using meta languages such as Haml, Sass and Coffeescript. 

It provides a [basic folder structure ](/docs/executable.md) to get started, a simple [layout engine](/docs/executable.md) and a [few helpers](/docs/executable.md) to make the work with PHP easier. Read the [documentation](/docs/index.md) to learn more.

***

### Installation

```bash
gem install meta_wordpress
```

### Bootstrapping

Navigate to the `/themes` folder of your Wordpress installation, then generate the necessary files to get started:

```bash
meta_wordpress bootstrap fancy_theme
```

### Start working

Within your new theme folder, start the file watcher (Guard) and you are good to go:

```bash
meta_wordpress start
```

**Read the [documentation](/docs/index.md) to learn more.**