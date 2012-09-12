require 'rubygems'
require 'bundler/setup'

require 'micktagger'

Dir[File.expand_path(File.dirname(__FILE__) + '/support/**/*.rb')].each {|f| require f}

RSpec.configure do |config|
  config.before(:each) do
    setup_test_env
    delete_fake_dotfile
  end

  config.after(:each) do
    delete_fake_dotfile
  end
end
