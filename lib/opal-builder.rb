require 'opal'

# Our fixes, need to go first so that require 'builder' is caught by us first
Opal.append_path File.expand_path('../../opal', __FILE__).untaint
# builder source itself
Opal.append_path File.expand_path('../../builder/lib', __FILE__).untaint

# Contains encoding that's not compatible
STUB_FILE = 'builder/xchar'

is_opal_09 = Opal::VERSION.include?('0.9')
if is_opal_09
  Opal::Processor.stub_file STUB_FILE
else
  Opal::Config.stubbed_files << STUB_FILE
end
