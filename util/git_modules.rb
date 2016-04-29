gem_dir = Gem::Specification.find_by_name('opal-rspec').gem_dir
unless Dir.exist?(File.join(gem_dir, 'rspec-core/spec'))
  puts 'Submodules for RSpec not there, fetching'
  result = Dir.chdir(gem_dir) { `git submodule update --init` }
  puts result
  raise 'Unable to checkout submodules' unless $?.success?
end
