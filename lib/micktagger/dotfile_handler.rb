module MickTagger
  class DotfileHandler
    def initialize
      @file_path = "#{ENV['HOME']}/.micktagger.json"
      @content   = load_content(@file_path)
    end

    def add_tag_to(file, tag)
      @content[file] ||= []
      @content[file] << tag
      @content[file].uniq!
    end

    def remove_tag_from(file, tag)
      @content[file].delete(tag)
      @content.delete(file) if @content[file].empty?
    end

    def save_file!
      File.open(@file_path, 'w') { |dotfile| dotfile.write(@content.to_json) }
    end

    def files_for(tag)
      @content.select { |file, tags| tags.include?(tag) }.keys
    end

    private

      def load_content(path)
        File.exists?(path) ? bootstrap_content(path) : {}
      end

      def bootstrap_content(path)
        existing_content = File.read(path)
        existing_content.empty? ? {} : JSON.parse(existing_content)
      end
  end
end
