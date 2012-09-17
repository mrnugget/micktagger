module MickTagger
  class CLI
    def self.dance!(args)
      dotfile_handler = DotfileHandler.new("#{ENV['HOME']}/.micktagger.json")
      file_store      = FileStore.new(dotfile_handler.load_content)
      parser          = OptionParser.new

      params          = {}
      output_lines    = []

      parser.on('-a', '--add [TAG]', String) do |tag|
        params[:action] = :add
        params[:tag]    = tag
      end

      parser.on('-d', '--delete [TAG]', String) do |tag|
        params[:action] = :delete
        params[:tag]    = tag
      end

      parser.on('-l', '--list [TAG]', String) do |tag|
        params[:action] = :list
        params[:tag]    = tag
      end

      parser.on('-h', '--help [TAG]', String) do |tag|
        puts parser
        exit
      end

      files = parser.parse!(args)

      if files.empty? && params[:action] && params[:action] != :list
        $stdin.each_line.each { |line| files << line.strip }
      end

      unless params[:action]
        puts parser
        exit
      end

      files.map! {|file| File.expand_path(file) }

      case params[:action]
      when :add
        files.each { |file| file_store.add_tag_to(file, params[:tag]) }
      when :delete
        files.each { |file| file_store.remove_tag_from(file, params[:tag]) }
      when :list
        output_lines << file_store.files_for(params[:tag])
      end

      dotfile_handler.save_to_file(file_store.content)

      output_lines.each { |line| $stdout.puts(line) }
    end
  end
end
