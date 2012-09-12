def setup_test_env
  # Modifying the PATH to prioritize the current executable
  ENV['PATH'] = "#{File.expand_path('../../../bin/', __FILE__)}:#{ENV['PATH']}"
  # Modifying HOME to test the micktagger dotfile
  ENV['HOME'] = File.expand_path('../../fixtures/fake_home/', __FILE__)
end
