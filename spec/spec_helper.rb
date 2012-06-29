$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require 'micktagger'

include MickTagger

# Muting the output when running specs
$stdout = StringIO.new
