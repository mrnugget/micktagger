# MickTagger
[![Build Status](https://secure.travis-ci.org/mrnugget/micktagger.png)](http://travis-ci.org/mrnugget/micktagger)

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

MickTagger loves pipes:

```
$ ls
empty_directory old.zip
$ ls | mt -a to_be_deleted
$ mt -l to_be_deleted
/Users/mrnugget/tmp/empty_directory
/Users/mrnugget/tmp/old.zip
$ mt -l to_be_deleted | xargs rm -rf
$ ls
<dir is empty>
```
... and a lot more!

## Installation

`gem install micktagger`

## License

MickTagger is released under the MIT license:

- www.opensource.org/licenses/MIT
