source 'https://rubygems.org'
gemspec

# Only run this if we don't have them
system 'git submodule update --init' unless Dir.glob('builder/**').any?

# Remove once we're using an opal-rspec GEM
system 'git submodule update --init; (cd opal-rspec; git submodule update --init)' unless Dir.glob('opal-rspec/**').any?

# Until opal-rspec is updated
gem 'opal-rspec', path: 'opal-rspec'

