require 'builder'
# TODO: Fold these into a single require
require 'builder/xmlbase_patched'

describe Builder do
  context 'basic case' do
    subject {      
      builder = Builder::XmlMarkup.new
      builder.person { |b| b.name("Jim"); b.phone("555-1234") }
    }
    
    it { is_expected.to eq '<person><name>Jim</name><phone>555-1234</phone></person>' }
  end
  
  context 'declare' do
    pending 'write it'
  end
end
