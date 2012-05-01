module MickTagger
  class App
    def self.parse(args)
      options                   = {}
      options[:db_file]         = File.expand_path('~/.micktagger.yml')
      options[:tags_to_remove]  = []
      options[:tags_to_add]     = []

      opts = OptionParser.new do |optparser|
        optparser.banner = "Usage: micktagger [file] [options]"
        optparser.separator ""
        optparser.separator "If called without options, micktagger shows the tags associated with the given file"
        optparser.separator ""
        optparser.separator "Options:"

        optparser.on("-a", "--add [TAGS]", Array, "Add tags to file") do |tags|
          options[:tags_to_add] = tags
        end

        optparser.on("-r", "--remove [TAGS]", Array, "Remove tags from file") do |tags|
          options[:tags_to_remove] = tags
        end

        optparser.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end
      opts.parse!(args)

      db = DB.new(options[:db_file])

      if args.length > 0
        # Adding a tag when called with 'app filename -a tagname'
        if args[0] && File.exists?(args[0]) && !options[:tags_to_add].empty?
          db.tag_file!(File.expand_path(args[0]), options[:tags_to_add])
          puts "Added tags '#{options[:tags_to_add].join(', ')}' to file '#{args[0]}'."
        # Removing a tag when called with 'app filename -r tagname'
        elsif args[0] && File.exists?(args[0]) && !options[:tags_to_remove].empty?
          db.untag_file!(File.expand_path(args[0]), options[:tags_to_remove])
          puts "Removed tag '#{options[:tags_to_remove].join(', ')}' from file '#{args[0]}'."
        # Show tags of a file when called with only a filename as argument
        elsif args[0] && File.exists?(args[0])
          tags_of_file = db.tags_of_file(File.expand_path(args[0]))
          unless tags_of_file.empty?
            puts "Tags associated with file '#{args[0]}':"
            tags_of_file.each {|tag| puts tag}
          else
            puts "No tags associated with '#{args[0]}'"
          end
        # Show files associated with a tag when called with 'list [tagname]'
        elsif args[0] == 'list'
          files = db.files_tagged_with(args[1])
          unless files.empty?
            puts "Files tagged with '#{args[1]}':"
            puts files
          else
            puts "No files tagged with '#{args[1]}'."
          end
        end
      else
        puts "You have to supply an argument when calling micktagger"
      end

      db.save
    end
  end
end
