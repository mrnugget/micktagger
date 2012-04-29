#!/usr/bin/env ruby -wKU

require 'optparse'
require './lib/micktagger'

module MickTagger
  class App
    def self.parse(args)
      options           = {}
      options[:db_file] = '~/.micktagger.yml'

      db = DB.new(options[:db_file])

      # Adding a tag when called with 'app filename tagname'
      if args[0] && File.exists?(args[0]) && args[1]
        db.tag_file!(File.expand_path(args[0]), [args[1]])
        puts "Added tag '#{args[1]}' to file '#{args[0]}'."
      # Show tags of a file when called with only a filename as argument
      elsif args[0] && File.exists?(args[0])
        tags_of_file = db.tags_of_file(File.expand_path(args[0]))
        unless tags_of_file.empty?
          puts "Tags associated with file '#{args[0]}':"
          tags_of_file.each {|tag| puts tag}
        else
          puts "No tags associated with '#{args[0]}'"
        end
      # Show files associated with a tag when called with tagname
      elsif !File.exists?(args[0])
        files_of_tag = db.files_of_tag(args[0])
        unless files_of_tag.empty?
          puts "Files tagged with '#{args[0]}':"
          puts files_of_tag
        else
          puts "No files tagged with '#{args[0]}'."
        end
      end

      db.save
    end
  end
end

MickTagger::App.parse(ARGV)
