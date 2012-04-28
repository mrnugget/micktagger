require 'spec_helper'
include MickTagger

describe App do
  describe 'using command-line arguments' do
    it 'allows to tag a file' do
      args = %w[spec/fixtures/test_picture.jpg cool]

      db = stub
      DB.should_receive(:new).with('~/.micktagger.yml') { db }
      db.should_receive(:tag_file!).with(File.expand_path('spec/fixtures/test_picture.jpg'), ['cool'])
      db.should_receive(:save)

      App.parse(args)
    end

    it 'allows to show the tags of a file' do
      args = %w[spec/fixtures/test_picture.jpg]

      db = stub
      DB.should_receive(:new).with('~/.micktagger.yml') { db }
      db.should_receive(:tags_of_file).with('spec/fixtures/test_picture.jpg').and_return(['cool'])
      db.should_receive(:save)

      App.parse(args)
    end
  end
end
