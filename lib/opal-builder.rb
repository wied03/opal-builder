require 'opal'

# builder source itself
Opal.append_path File.expand_path('../../builder/lib', __FILE__).untaint
# our xchar_patched
Opal.append_path File.expand_path('../../opal', __FILE__).untaint
# Contains encoding that's not compatible
Opal::Processor.stub_file 'builder/xchar'
