# -*- encoding: utf-8 -*-
require File.expand_path('../builder/lib/builder/version', __FILE__)

Gem::Specification.new do |s|
  s.name         = 'opal-builder'
  s.version      =  Builder::VERSION
  s.author       = 'Brady Wied'
  s.email        = 'brady@bswtechconsulting.com'
  s.summary      = 'Builder for Opal'
  s.description  = 'Opal compatible builder library'

  s.files = `git ls-files`.split("\n") + FileList['builder/**/*.rb']

  s.require_paths  = ['lib']

  s.add_dependency 'opal', ['>= 0.7.0', '< 0.9']
  s.add_development_dependency 'rake', '~> 10'
end
