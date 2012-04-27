require 'spec_helper'

describe Tag do

  before(:each) do
    @tag = Tag.new("testing")
  end

  it "is empty when initialized" do
    @tag.files.should be_empty
    @tag.no_files?.should be_true
  end

  it "allows to add files" do
    @tag.add_file("testing.txt")

    @tag.files.should include("testing.txt")
  end

  it "allows to remove files" do
    @tag.stub(files: ["anotherfile.mkv"])
    @tag.remove_file("testing.txt")

    @tag.files.should_not include("testing.txt")
  end
end
