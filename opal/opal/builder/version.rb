require 'builder/version'

module Opal
  module OpalBuilder
    # Add a minor version to the end in case there are opal-builder specific issues to fix
    VERSION = "#{::Builder::VERSION}.3"
  end
end
