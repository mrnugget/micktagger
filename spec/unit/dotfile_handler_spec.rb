require 'spec_helper'

describe MickTagger::DotfileHandler do
  let(:handler) do
    MickTagger::DotfileHandler.new
  end

  describe '#add_tag_to' do
    it 'allows me to add a tag to a file' do
      handler.add_tag_to('/Users/mrnugget/todo.txt', 'important')
      handler.save_file!

      dotfile = read_and_parse_fake_dotfile
      dotfile['/Users/mrnugget/todo.txt'].should == ['important']
    end

    it 'allows me to add several tags to a file' do
      handler.add_tag_to('/Users/mrnugget/readme.md', 'markdown')
      handler.add_tag_to('/Users/mrnugget/readme.md', 'important')
      handler.save_file!

      dotfile = read_and_parse_fake_dotfile
      dotfile['/Users/mrnugget/readme.md'].should == ['markdown', 'important']
    end

    it 'does not keep duplicate tags in the file' do
      handler.add_tag_to('/Users/mrnugget/todo.txt', 'important')
      handler.add_tag_to('/Users/mrnugget/todo.txt', 'important')
      handler.save_file!

      dotfile = read_and_parse_fake_dotfile
      dotfile['/Users/mrnugget/todo.txt'].should == ['important']
    end
  end

  describe '#remove_tag_from' do
    before(:each) do
      handler.add_tag_to('/Users/mrnugget/todo.txt', 'important')
      handler.add_tag_to('/Users/mrnugget/readme.md', 'markdown')
      handler.add_tag_to('/Users/mrnugget/readme.md', 'important')
      handler.save_file!
    end

    it 'allows me to remove tags from a file' do
      handler.remove_tag_from('/Users/mrnugget/readme.md', 'markdown')
      handler.save_file!

      dotfile = read_and_parse_fake_dotfile
      dotfile['/Users/mrnugget/readme.md'].should_not include('markdown')
    end

    it 'removes files from dotfile if they have not tags' do
      handler.remove_tag_from('/Users/mrnugget/todo.txt', 'important')
      handler.save_file!

      dotfile = read_and_parse_fake_dotfile
      dotfile.should_not include('/Users/mrnugget/todo.txt')
    end
  end
end
