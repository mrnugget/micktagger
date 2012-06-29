require 'spec_helper'

describe App do
  describe 'using command-line arguments' do
    before(:each) do
      @db = stub(:db).as_null_object
      DB.stub(new: @db)
    end

    it 'allows to tag a file when called with "[filename] -a [tagname]"' do
      args = %w[spec/fixtures/test_picture.jpg -a cool]

      @db.should_receive(:tag_file!).with(File.expand_path('spec/fixtures/test_picture.jpg'), ['cool'])

      App.parse(args)
    end

    it 'allows to remove a tag from a file when called with "[filename] -r [tagname]"' do
      args = %w[spec/fixtures/test_picture.jpg -r cool]

      @db.should_receive(:untag_file!).with(File.expand_path('spec/fixtures/test_picture.jpg'), ['cool'])

      App.parse(args)
    end

    it 'shows the tags of a file when called with only filename' do
      args = %w[spec/fixtures/test_picture.jpg]

      @db.should_receive(:tags_of_file).with(File.expand_path('spec/fixtures/test_picture.jpg')).and_return(['cool'])

      App.parse(args)
    end

    it 'shows the files associated with a tag when called with "list [tagname]"' do
      @db.stub(files_tagged_with: File.expand_path('spec/fixtures/test_picture.jpg'))

      args = %w[list cool]

      @db.should_receive(:files_tagged_with).with('cool')

      App.parse(args)
    end
  end
end
