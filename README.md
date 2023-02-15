# slim-rails [![Gem Version](https://img.shields.io/gem/v/slim-rails.svg)](http://rubygems.org/gems/slim-rails) [![Build Status](https://github.com/slim-template/slim-rails/actions/workflows/main.yml/badge.svg)](https://github.com/slim-template/slim-rails/actions/workflows/main.yml) [![Code Climate](https://codeclimate.com/github/slim-template/slim-rails/badges/gpa.svg)](https://codeclimate.com/github/slim-template/slim-rails)

slim-rails provides Slim generators for Rails:

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

Every time you generate a controller or scaffold, you'll get Slim templates.

If you have existing `.erb` templates, check out our guide [How to convert your `.erb` templates to `.slim`](https://github.com/slim-template/slim/wiki/Template-Converters-ERB-to-SLIM) on how to achieve this.

This gem is [tested with Ruby on Rails 5.2+](/.github/workflows/main.yml).

## History

`slim-rails` was based on [haml-rails](https://github.com/haml/haml-rails) and it does basically the same thing.

From the version 0.2.0, there is no need to include gem "slim" in your Gemfile.
