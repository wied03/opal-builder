require 'opal'

# Our fixes, need to go first so that require 'builder' is caught by us first
Opal.append_path File.expand_path('../../opal', __FILE__).untaint
# builder source itself
Opal.append_path File.expand_path('../../builder/lib', __FILE__).untaint
# Contains encoding that's not compatible
Opal::Processor.stub_file 'builder/xchar'
