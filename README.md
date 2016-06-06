# slim-rails [![Build Status](https://travis-ci.org/slim-template/slim-rails.png?branch=master)](https://travis-ci.org/slim-template/slim-rails) [![Code Climate](https://codeclimate.com/github/slim-template/slim-rails/badges/gpa.svg)](https://codeclimate.com/github/slim-template/slim-rails)

slim-rails provides Slim generators for Rails 3+. It was based on
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