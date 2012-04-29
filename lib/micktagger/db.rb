module MickTagger
  class DB
    attr_accessor :tags

    def initialize(db_file = File.expand_path('~/.micktagger.yml'))
      @db_file = File.expand_path db_file
      @tags = load_db(@db_file)
    end

    def files_of_tag(tag_name)
      if tag = find_tag(tag_name)
        tag.files
      else
        []
      end
    end

    def tags_of_file(file)
      file_tags = []
      @tags.each do |name, tag_object|
        file_tags << name if tag_object.files.include? file
      end
      file_tags
    end

    def tag_file!(file, tag_names)
      tag_names.each do |tag_name| 
        tag = find_tag(tag_name) || Tag.new(tag_name)
        add_file_to_tag(tag, file)
      end
    end

    def untag_file!(file, tag_names)
      tag_names.each do |tag_name| 
        tag = find_tag(tag_name)
        remove_file_from_tag(tag, file) unless tag
      end
    end

    def tag_files!(files, tag_name)
      files.each { |f| tag_file!(f, [tag_name]) }
    end

    def save
      write_db
    end

    private

      def add_file_to_tag(tag, file)
        tag.add_file(file)
        save_tag(tag)
      end

      def find_tag(tag_name)
        @tags[tag_name] || nil
      end

      def load_db(db_file)
        YAML.load_file(db_file) || {}
      end
      
      def remove_file_from_tag(tag, file)
        tag.remove_file(file)
        tag.no_files? ? remove_tag(tag) : save_tag(tag)
      end

      def remove_tag(tag)
        @tags.delete(tag.name)
      end

      def save_tag(tag)
        @tags[tag.name] = tag
      end

      def print_tag_files(tag) 
        tag.files.each { |f| puts f }
      end
      
      def write_db
        File.write(@db_file, @tags.to_yaml)
      end
  end
end
