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
  end
end
