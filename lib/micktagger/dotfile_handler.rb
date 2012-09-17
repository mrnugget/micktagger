module MickTagger
  class DotfileHandler
    def initialize(path)
      @path = path
    end

    def save_to_file(content)
      File.open(@path, 'w') { |dotfile| dotfile.write(content.to_json) }
    end

    def load_content
      File.exists?(@path) ? bootstrap_content : {}
    end

    private

      def bootstrap_content
        existing_content = File.read(@path)
        existing_content.empty? ? {} : JSON.parse(existing_content)
      end
  end
end
