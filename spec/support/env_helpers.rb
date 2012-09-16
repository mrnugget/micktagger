def setup_test_env
  # Modifying the PATH to prioritize the current executable
  ENV['PATH'] = "#{File.expand_path('../../../bin/', __FILE__)}:#{ENV['PATH']}"
  # Modifying HOME to test the micktagger dotfile
  ENV['HOME'] = File.expand_path('../../fixtures/fake_home/', __FILE__)
end

def capture_stdout
  output  = StringIO.new
  $stdout = output
  yield
  return output
ensure
  $stdout = STDOUT
end

def in_stdin(content)
  $stdin = content
  yield
ensure
  $stdin = STDIN
end
