require 'spec_helper'

describe MickTagger::FileStore do
  let(:store) do
    MickTagger::FileStore.new({'myfile.txt' => ['important']})
  end

  describe '#files_for' do
    it 'lists the files tagged with a specified tag' do
      store.files_for('important').should == ['myfile.txt']
    end
  end

  describe '#add_tag_to' do
    it 'allows me to add a tag to a file' do
      store.add_tag_to('myfile.txt', 'cool')

      store.files_for('cool').should == ['myfile.txt']
    end

    it 'ignores duplicate tag entries for each file' do
      store.add_tag_to('myfile.txt', 'important')

      store.content['myfile.txt'].should == ['important']
    end
  end

  describe '#remove_tag_from' do
    it 'allows me to remove a tag from a file' do
      store.remove_tag_from('myfile.txt', 'important')

      store.files_for('important').should be_empty
    end

    it 'removes the file from the store if it has no tags left' do
      store.remove_tag_from('myfile.txt', 'important')

      store.content['myfile.txt'].should be_nil
    end
  end
end
