module MickTagger
  class DB
    attr_accessor :db

    def initialize(db_file = "$HOME/.micktagger.yaml")
      @db_file = db_file
      @db = load_db(@db_file)
    end

    def show_files(tag_name)
      tag = find_tag tag_name
      return puts "No files associated with this tag" unless tag
      print_tag_files(tag)
    end

    def show_tags(file)
      @db.each do |name, object|
        puts name if object.files.include? file
      end
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
      files.each { |f| tag_file(f, tag_name) }
    end

    def save
      write_db
    end

    private

      # Add a file to a tags files
      def add_file_to_tag(tag, file)
        tag.add_file(file)
        save_tag(tag)
      end

      def find_tag(tag_name)
        @db[tag_name] || nil
      end

      # Returns DB
      def load_db(db_file)
        YAML.load_file(db_file) || {}
      end
      
      # Unassociate a file with a tag
      def remove_file_from_tag(tag, file)
        tag.remove_file(file)
        tag.no_files? ? remove_tag(tag) : save_tag(tag)
      end

      # Remove a tag from DB
      def remove_tag(tag)
        @db.delete(tag.name)
      end

      # Add a tag and a file to DB
      def save_tag(tag)
        @db[tag.name] = tag
      end

      def print_tag_files(tag) 
        tag.files.each { |f| puts f }
      end
      
      # Writes DB to file
      def write_db
        File.write(@db_file, @db.to_yaml)
      end
  end
end
