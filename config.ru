require 'bundler'
Bundler.require

Opal::Processor.source_map_enabled = false

require 'opal-builder'
puts "opal apths #{Opal.paths}"

run Opal::Server.new { |s|
  s.main = 'opal/rspec/sprockets_runner'
  s.append_path 'spec'
  s.debug = false
}
