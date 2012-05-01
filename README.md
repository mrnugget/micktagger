# MickTagger

MickTagger is a small command line utility written in ruby that allows you to
tag files and saves those tags to `~/.micktagger.yml`

## Example

```
$ micktagger dude.yml -a delete_this
Added tag 'delete_this' to file 'dude.yml'.
$ micktagger Gemfile -a important!
Added tag 'important!' to file 'Gemfile'.
$ micktagger dude.yml
Tags associated with file 'dude.yml':
delete_this
$ micktagger list important!
Files tagged with 'important!':
/Users/mrnugget/code/micktagger/Gemfile
```

## Installation

MickTagger has a gemspec, but since there are still lots of bugs and errors in
the app, I don't want to push it to rubygems.org yet.

To install this programm, follow these steps:

- `git clone git://github.com/mrnugget/micktagger.git`
- `cd micktagger`
- `gem build micktagger.gemspec`
- `gem install micktagger-0.0.1.gem`
- `touch ~/.micktagger.yml`

Now start a new shell, and you should be able to use the micktagger command. 

### Running the tests

The tests are all rspec tests. So in order to run them, follow these steps:

- `cd micktagger`
- `bundle install`
- `bundle exec rspec spec/`

## Usage

This is the output from `micktagger -h`

```
Usage: micktagger [file] [options]

If called without options, micktagger shows the tags associated with the given file

Options:
    -a, --add [TAGS]                 Add tags to file
    -r, --remove [TAGS]              Remove tags from file
    -h, --help                       Show this message
```

You can supply several tags by seperating them with a `,`, e.g.
`micktagger gimmeshelter_lyrics.txt -a todo,finish_this,needs_drums`

You can get a list of all files associated with a certain tag by using `list`:

```
$ micktagger mydocument.txt -a important
$ micktagger list important
```

## TODO

- Check if `micktagger.yml` exists. If not: create it!
- Make that crazy if-elsif ugliness in `app.rb` go away!
- Add the CLI option to specify a different YAML file to load and save tags
- Refactor those tests! Especially `unit/app_spec.rb`. There should be a lot
  more stubbing going on.
- Clean up `MickTagger::DB`: The interface should be smaller. Maybe add an
  additional layer between `MickTagger::DB` and `MickTagger::App` that creates
  the Tags and DB just stores them.
- Add an option to output just the tags or just the filenames, no comments and
  nothing, in order to get it working with shell pipes.

## License

MickTagger is released under the MIT license:

- www.opensource.org/licenses/MIT
