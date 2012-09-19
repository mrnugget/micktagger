require 'spec_helper'

describe 'micktagger command line interface' do
  it 'allows me to add tags to a file, list the files of for tag and remove tags' do
    readme_full_path = File.expand_path('../../../README.md', __FILE__)

    MickTagger::CLI.dance!(['-a', 'important', 'README.md'])

    dotfile = read_and_parse_fake_dotfile
    dotfile[readme_full_path].should == ['important']

    output = capture_stdout do
      MickTagger::CLI.dance!(['-l', 'important'])
    end
    output.string.should match(readme_full_path)

    MickTagger::CLI.dance!(['-a', 'markdown', 'README.md'])

    dotfile = read_and_parse_fake_dotfile
    dotfile[readme_full_path].should include('important')
    dotfile[readme_full_path].should include('markdown')

    MickTagger::CLI.dance!(['-d', 'important', 'README.md'])

    dotfile = read_and_parse_fake_dotfile
    dotfile[readme_full_path].should_not include('important')

    MickTagger::CLI.dance!(['-d', 'markdown', 'README.md'])

    dotfile = read_and_parse_fake_dotfile
    dotfile.should_not include(readme_full_path)
  end

  it 'allows me to tag files piped to STDIN' do
    dir   = "#{ENV['HOME']}"
    stdin = "#{dir}/readme.md\n#{dir}/delete_after_reading.txt"

    in_stdin(stdin) do
      MickTagger::CLI.dance!(['-a', 'important'])
    end

    dotfile = read_and_parse_fake_dotfile
    dotfile["#{dir}/readme.md"].should include('important')
    dotfile["#{dir}/delete_after_reading.txt"].should include('important')
  end

  it 'allows me to remove files that have been deleted' do
    readme_full_path = File.expand_path('../../../README.md', __FILE__)
    MickTagger::CLI.dance!(['-a', 'important', 'README.md'])

    File.stub(exists?: true)
    File.stub(:exists?).with(readme_full_path).and_return(false)

    output = capture_stdout do
      MickTagger::CLI.dance!(['-c'])
    end
    output.string.should match("Deleted files:\n#{readme_full_path}\n")

    dotfile = read_and_parse_fake_dotfile
    dotfile.should_not include(readme_full_path)
  end
end
