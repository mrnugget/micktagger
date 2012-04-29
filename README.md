# MickTagger

MickTagger is a small command line utility written in ruby that allows you to
tag files and saves those tags to `~/.micktagger.yml`

## Example

```
$ ruby -Ilib bin/micktagger dude.yml delete_this
Added tag 'delete_this' to file 'dude.yml'.
$ ruby -Ilib bin/micktagger Gemfile important!
Added tag 'important!' to file 'Gemfile'.
$ ruby -Ilib bin/micktagger dude.yml
Tags associated with file 'dude.yml':
delete_this
$ ruby -Ilib bin/micktagger important!
Files tagged with 'important!':
/Users/mrnugget/code/micktagger/Gemfile
```

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
