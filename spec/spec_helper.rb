load File.join(File.dirname(__FILE__), '../bin/micktagger')
require_relative '../lib/micktagger'

include MickTagger

# Muting the output when running specs
$stdout = StringIO.new
