require 'spec_helper'

describe MickTagger::FileStore do
  describe '#files_for' do
    it 'lists the files tagged with a specified tag' do
      store = MickTagger::FileStore.new({'myfile.txt' => ['important']})

      store.files_for('important').should == ['myfile.txt']
    end
  end

  describe '#add_tag_to' do
    it 'allows me to add a tag to a file' do
      store = MickTagger::FileStore.new({'myfile.txt' => ['important']})

      store.add_tag_to('myfile.txt', 'cool')

      store.files_for('cool').should == ['myfile.txt']
    end
  end

  describe '#remove_tag_from' do
    it 'allows me to remove a tag from a file' do
      store = MickTagger::FileStore.new({'myfile.txt' => ['important']})

      store.remove_tag_from('myfile.txt', 'important')

      store.files_for('important').should be_empty
    end
  end
end
