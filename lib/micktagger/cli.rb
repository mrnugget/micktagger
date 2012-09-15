module MickTagger
  class CLI
    def self.dance!
      dotfile_handler = DotfileHandler.new
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

      files = parser.parse!

      if files.empty? && params[:action] != :list
        $stdin.each_line.each { |line| files << line.strip }
      end

      files.map! {|file| File.expand_path(file) }

      case params[:action]
      when :add
        files.each { |file| dotfile_handler.add_tag_to(file, params[:tag]) }
      when :delete
        files.each { |file| dotfile_handler.remove_tag_from(file, params[:tag]) }
      when :list
        output_lines << dotfile_handler.files_for(params[:tag])
      end

      dotfile_handler.save_file!

      output_lines.each { |line| $stdout.puts(line) }
    end
  end
end
