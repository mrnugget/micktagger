Gem::Specification.new do |s|
  s.name = 'micktagger'
  s.version = '0.0.1'
  s.date = '2012-04-29'
  s.summary = 'MickTagger'
  s.description = 'CLI tool to tag files'
  s.homepage = 'https://github.com/mrnugget/micktagger'
  s.authors = ['Thorsten Ball']
  s.email = 'mrnugget@gmail.com'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
