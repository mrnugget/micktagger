# MickTagger

MickTagger is a small command line utility written in ruby that allows you to
tag files and saves those tags to `~/.micktagger.yml`

## Example

```
$ micktagger dude.yml delete_this
Added tag 'delete_this' to file 'dude.yml'.
$ micktagger Gemfile important!
Added tag 'important!' to file 'Gemfile'.
$ micktagger dude.yml
Tags associated with file 'dude.yml':
delete_this
$ micktagger important!
Files tagged with 'important!':
/Users/mrnugget/code/micktagger/Gemfile
```

## Installation

MickTagger has a gemspec, but since the code isn't really that good, there are
lots of bugs and errors in the app, I don't want to push it to rubygems.org yet.

To install this programm, follow these steps:

- `git clone git://github.com/mrnugget/micktagger.git`
- `cd micktagger`
- `gem build micktagger.gemspec`
- `gem install micktagger-0.0.1.gem`

Now start a new shell, and you should be able to use the micktagger command. 

### Running the tests

The tests are all rspec tests. So in order to run them, follow these steps:

- `cd micktagger`
- `bundle install`
- `bundle exec rspec spec/`

## TODO

- Throw out horrible code in `bin/micktagger`, use OptionParser when necessary
- Add the CLI option to specify a different YAML file to load and save tags
- Refactor those tests! Especially `unit/app_spec.rb`. There should be a lot
  more stubbing going on.
- Clean up `MickTagger::DB`: The interface should be smaller. Maybe add an
  additional layer between `MickTagger::DB` and `MickTagger::App` that creates
  the Tags and DB just stores them.

## License

MickTagger is released under the MIT license:

- www.opensource.org/licenses/MIT
