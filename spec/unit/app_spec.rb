require 'spec_helper'

describe App do
  describe 'using command-line arguments' do
    it 'allows to tag a file when called with filename and tagname' do
      args = %w[spec/fixtures/test_picture.jpg cool]

      db = stub
      DB.should_receive(:new).with(File.expand_path('~/.micktagger.yml')) { db }
      db.should_receive(:tag_file!).with(File.expand_path('spec/fixtures/test_picture.jpg'), ['cool'])
      db.should_receive(:save)

      App.parse(args)
    end

    it 'shows the tags of a file when called with only filename' do
      args = %w[spec/fixtures/test_picture.jpg]

      db = stub
      DB.should_receive(:new).with(File.expand_path('~/.micktagger.yml')) { db }
      db.should_receive(:tags_of_file).with(File.expand_path('spec/fixtures/test_picture.jpg')).and_return(['cool'])
      db.should_receive(:save)

      App.parse(args)
    end
    it 'shows the files associated with a tag when called only with tagname' do
      args = %w[spec/fixtures/test_picture.jpg cool]
      App.parse(args)

      args = %w[cool]
      db = stub
      DB.should_receive(:new).with(File.expand_path('~/.micktagger.yml')) { db }
      db.should_receive(:files_of_tag).with('cool').and_return(File.expand_path('spec/fixtures/test_picture.jpg'))
      db.should_receive(:save)

      App.parse(args)
    end
  end
end
