module MickTagger
  class FileStore
    attr_reader :content

    def initialize(content)
      @content = content
    end

    def files_for(tag)
      @content.select {|file, tags| tags.include?(tag) }.keys
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

    def remove_deleted_files!
      @content.keys.inject([]) do |deleted_files, file|
        unless File.exists?(file)
          @content.delete(file)
          deleted_files << file
        end
        deleted_files
      end
    end
  end
end
