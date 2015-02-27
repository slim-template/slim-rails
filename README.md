# slim-rails

slim-rails provides Slim generators for Rails 3 and 4. It was based on
[haml-rails](http://github.com/indirect/haml-rails) and it does basically the
same:

* Any time you generate a controller or scaffold, you'll get Slim templates
  (instead of ERB)
* When your Rails application loads, Slim will be loaded and initialized
  automatically
* Slim templates will be respected by the view template cache digestor

To use it, add this line to your Gemfile:

```ruby
gem "slim-rails"
```

And that's it.

From the version 0.2.0, there is no need to include gem "slim" in your Gemfile.

Every time you generate a controller or scaffold, you'll get Slim templates.

__Pretty mode is enabled in development!__

Since 3.0 Slim works in pretty mode in development, but remains `pretty: false` in all other environments. This is useful for debugging, but can lead to different page renderings between environments (missing whitespaces in production).

You can disable pretty mode for all environments by creating `config/initializers/slim.rb` with
```ruby
Slim::Engine.set_options(
  pretty:     false,
)
```
