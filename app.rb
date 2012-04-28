#!/usr/bin/env ruby -wKU

require 'optparse'
require './lib/micktagger'

module MickTagger
  class App
    def self.parse(args)
      options           = {}
      options[:db_file] = '~/.micktagger.yml'

      if args[0] && File.exists?(args[0]) && args[1]
        db = DB.new(options[:db_file])
        db.tag_file!(File.expand_path(args[0]), [args[1]])
        db.save
      elsif args[0] && File.exists?(args[0])
        db = DB.new(options[:db_file])
        puts db.tags_of_file(args[0])
        db.save
      end
    end
  end
end

MickTagger::App.parse(ARGV)
