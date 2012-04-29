Gem::Specification.new do |s|
  s.name = 'micktagger'
  s.version = '0.0.1'
  s.date = '2012-04-29'
  s.summary = 'MickTagger'
  s.description = 'CLI tool to tag files'
  s.homepage = 'https://github.com/mrnugget/micktagger'
  s.authors = ['Thorsten Ball']
  s.email = 'mrnugget@gmail.com'
  s.files = ["lib/micktagger.rb", "lib/micktagger/tag.rb", "lib/micktagger/db.rb"]
  s.executables << 'micktagger'
end
