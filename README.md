# MickTagger

MickTagger is a command line utility that allows you to tag files.

It only uses JSON file placed in your home directory as `.micktagger.json` to
save those file and tags associations.

## Usage & Examples

```
$ mt -a important Gemfile
$ mt -l important
/Users/mrnugget/code/micktagger/Gemfile
$ mt -a to_be_deleted ~/tmp/git_testing
$ mt -a to_be_deleted ~/tmp/install.zip
$ mt -l to_be_deleted
/Users/mrnugget/tmp/git_testing
/Users/mrnugget/tmp/install.zip
$ mt -d to_be_deleted ~/tmp/install.zip
$ mt -l to_be_deleted
/Users/mrnugget/tmp/git_testing
```

## Installation

`gem install micktagger`

## License

MickTagger is released under the MIT license:

- www.opensource.org/licenses/MIT
