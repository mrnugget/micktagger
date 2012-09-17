require 'spec_helper'

describe MickTagger::DotfileHandler do
  let(:handler) do
    MickTagger::DotfileHandler.new("#{ENV['HOME']}/.micktagger.json")
  end

  describe '#save_to_file' do
    it 'allows me to save serialized contents to the dotfile' do
      handler.save_to_file({'readme.md' => ['cool']})

      dotfile = read_and_parse_fake_dotfile
      dotfile['readme.md'].should == ['cool']
    end
  end

  describe '#load_content' do
    context 'the dotfile is empty' do
      it 'gives me an empty hash' do
        handler.load_content.should == {}
      end
    end

    context 'the dotfile contains serialized information' do
      before do
        handler.save_to_file({'readme.md' => ['cool']})
      end

      it 'loads the file and deserializes the content' do
        handler.load_content.should == {'readme.md' => ['cool']}
      end
    end
  end
end
