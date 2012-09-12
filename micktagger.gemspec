require File.expand_path('../lib/micktagger/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Thorsten Ball"]
  gem.email         = ["mrnugget@gmail.com"]
  gem.description   = %q{MickTagger is a command line utility that allows you to tag files.}
  gem.summary       = %q{
    With MickTagger you can tag files, list files tagged with a specified tag,
    remove tags and do cool stuff — all on the command line!
    It only needs a small json dotfile in your homedirectory to save that information.
  }
  gem.homepage      = "http://www.github.com/mrnugget/micktagger"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "micktagger"
  gem.require_paths = ["lib"]
  gem.version       = MickTagger::VERSION

  gem.add_development_dependency 'rspec'
end
