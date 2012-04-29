require_relative '../app'
require_relative '../lib/micktagger'

include MickTagger

# Muting the output when running specs
$stdout = StringIO.new
