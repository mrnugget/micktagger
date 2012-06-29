require 'spec_helper'

describe DB do
  before(:each) do
    @db = DB.new('./spec/fixtures/test_db_empty.yml')

    @tag = stub(:tag)
    @tag.stub(name: 'great')
    Tag.stub(new: @tag)
  end

  it 'allows to tag a file' do
    Tag.should_receive(:new).with('great').and_return(@tag)
    @tag.should_receive(:add_file).with('testing.txt')

    @db.tag_file!('testing.txt', ['great'])
  end

  it 'allows to tag several files' do
    @tag.should_receive(:add_file).twice

    @db.tag_files!(['testing.txt', 'picture.jpg'], 'great')
  end

  it 'allows to save the DB to the file' do
    File.should_receive(:write).with(
      File.expand_path('spec/fixtures/test_db_empty.yml'),
      Hash.new.to_yaml
    )

    @db.save
  end

  context 'with tags saved to the database file' do
    before(:each) do
      @db = DB.new('spec/fixtures/test_db_with_content.yml')
    end

    it 'allows to see the tags of a file' do
      @db.tags_of_file('testing.txt').should include('great')
    end

    it 'allows to see the files associated with a tag' do
      @db.files_tagged_with('great').should include('testing.txt')
    end
  end
end
