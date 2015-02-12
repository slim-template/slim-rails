# slim-rails

Slim-rails provides Slim generators for Rails 4. It also enables Slim as the templating engine for you, so you don't have to screw around in your own application.rb when your Gemfile already clearly indicated what templating engine you have installed. Hurrah. It was based on
[haml-rails](http://github.com/indirect/haml-rails).

To use it, add this line to your Gemfile:

``` gem "slim-rails" ```


This ensures that:


* Any time you generate a controller or scaffold, you'll get Slim templates
  (instead of ERB)
* When your Rails application loads, Slim will be loaded and initialized
  automatically
* Slim templates will be respected by the view template cache digestor

Yes it does the same thing as haml-rails but better because well... slim beats haml anyday.

### Converting Rails application layout file to haml format

Once Slim-rails is installed on the Rails application,
you can convert the erb layout file, `app/views/layouts/application.html.erb`
to `app/views/layouts/application.html.slim` using this command:

    $ rails generate slim:application_layout convert

After the application layout file is converted successfully,
make sure to delete `app/views/layouts/application.html.erb`, so Rails can
start using `app/views/layouts/application.html.haml` instead.

### Converting all .erb views to slim format

If you want to convert all of your .erb views into .slim, you can do so using the following command:

    $ rake slim:erb2slim

If you already have .slim files for one or more of the .erb files, the rake task will give you the option of either
replacing these .slim files or leaving them in place.

Once the task is complete, you will have the option of deleting the original .erb files. Unless you are under
version control, it is recommended that you decline this option.

And that's it.

From the version 0.2.0, there is no need to include gem "slim" in your Gemfile.

Every time you generate a controller or scaffold, you'll get Slim templates.

### License

Ruby license or MIT license, take your pick.
