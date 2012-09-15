require 'spec_helper'

describe 'micktagger command line interface' do
  it 'allows me to add tags to a file, list the files of for tag and remove tags' do
    readme_full_path = File.expand_path('../../../README.md', __FILE__)

    `mt -a important README.md`

    dotfile = read_and_parse_fake_dotfile
    dotfile[readme_full_path].should == ['important']

    output = `mt -l important`
    output.should match(readme_full_path)

    `mt -a markdown README.md`

    dotfile = read_and_parse_fake_dotfile
    dotfile[readme_full_path].should include('important')
    dotfile[readme_full_path].should include('markdown')

    `mt -d important README.md`

    dotfile = read_and_parse_fake_dotfile
    dotfile[readme_full_path].should_not include('important')

    `mt -d markdown README.md`

    dotfile = read_and_parse_fake_dotfile
    dotfile.should_not include(readme_full_path)
  end

  it 'allows me to tag files piped to STDIN' do
    dir = "#{ENV['HOME']}"

    `cd #{dir} && ls #{dir} | mt -a important`

    dotfile = read_and_parse_fake_dotfile

    dotfile["#{dir}/readme.md"].should include('important')
    dotfile["#{dir}/delete_after_reading.txt"].should include('important')
  end
end
