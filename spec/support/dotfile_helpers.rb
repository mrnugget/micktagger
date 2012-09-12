def fake_dotfile
  File.expand_path('../../fixtures/fake_home/.micktagger.json', __FILE__)
end

def delete_fake_dotfile
  File.delete(fake_dotfile) if File.exists?(fake_dotfile)
end

def read_and_parse_fake_dotfile
  JSON.parse(File.read(fake_dotfile))
end
