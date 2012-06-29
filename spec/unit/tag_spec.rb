require 'spec_helper'

describe Tag do

  let(:tag) do
    Tag.new('testing')
  end

  it 'has no files associated with it when initialized' do
    tag.files.should be_empty
    tag.no_files?.should be_true
  end

  it 'allows to associate files' do
    tag.add_file('testing.txt')

    tag.files.should include("testing.txt")
  end

  it 'allows to remove files' do
    tag.add_file('the_first_file.txt')
    tag.add_file('the_second_file.txt')

    tag.remove_file('the_first_file.txt')

    tag.files.should_not include('the_first_file.txt')
    tag.files.count.should eq(1)
  end
end
