# -*- encoding: utf-8 -*-
$: << File.expand_path('../builder/lib', __FILE__)
require File.expand_path('../opal/opal/builder/version', __FILE__)

Gem::Specification.new do |s|
  s.name         = 'opal-builder'
  s.version      =  Opal::OpalBuilder::VERSION
  s.author       = 'Brady Wied'
  s.email        = 'brady@bswtechconsulting.com'
  s.summary      = 'Builder for Opal'
  s.description  = 'Opal compatible builder library'
  s.homepage     = 'https://github.com/wied03/opal-builder'

  s.files = `git ls-files`.split("\n") + Dir.glob('builder/lib/**/*.rb')

  s.require_paths  = ['lib']

  s.add_dependency 'opal', ['>= 0.8.0']
  s.add_development_dependency 'rake'
end
