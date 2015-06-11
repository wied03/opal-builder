source 'https://rubygems.org'
gemspec

# Only run this if we don't have them
system 'git submodule update --init' unless Dir.glob('builder/**').any?
gem 'opal', git: 'https://github.com/opal/opal.git'
# Until opal-rspec is updated
gem 'opal-rspec', path: 'opal-rspec'

