#!/usr/bin/env ruby -wKU

require './lib/micktagger'

db = MickTagger::DB.new("dude.yml")

if File.file? ARGV[0] || File.directory?(ARGV[0])

  file = File.expand_path(ARGV[0])
  if ARGV[1] == "add" || ARGV[1] == "-a"
    db.tag_file!(file, ARGV[2..-1])
  elsif ARGV[1] == "remove" || ARGV[1] == "-r"
    db.untag_file!(file, ARGV[2..-1])
  else
    puts "Show tags of file '#{file}':"
    db.show_tags(file)
  end

elsif ARGV[0] == "show"

  if File.file? ARGV[1] || File.directory?(ARGV[1]) 
    puts "Show tags of file '#{ARGV[1]}':"
    db.show_tags(File.expand_path(ARGV[1]))
  else
    puts "Show files tagged with '#{ARGV[1]}':"
    db.show_files(ARGV[1])
  end
end

db.save
