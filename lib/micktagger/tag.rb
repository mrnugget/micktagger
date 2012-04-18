module MickTagger
  class Tag
    attr_accessor :files, :name

    def initialize(name)
      @files = []
      @name = name
    end

    def no_files?
      @files.empty?
    end

    def add_file(file)
      @files << file
      @files.uniq!
    end

    def remove_file(file)
      @files.delete(file)
    end
  end
end
