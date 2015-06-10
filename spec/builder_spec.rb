require 'builder'
# TODO: Fold these into a single require
require 'builder/xmlbase_patched'

describe Builder::XmlMarkup do
  let(:options) { {} }
  let(:builder) { Builder::XmlMarkup.new options }
  
  context 'basic case' do
    subject { builder.person { |b| b.name("Jim"); b.phone("555-1234") } }    

    it { is_expected.to eq '<person><name>Jim</name><phone>555-1234</phone></person>' }
  end
  
  context 'indent' do
    let(:options) { {indent: 2}}
    subject {
      r = builder.person { |b| b.name("Jim"); b.phone("555-1234") }
      # for some reason, carriage returns aren't making it otherwise
      r.to_s
    }   
    
    it { 
      is_expected.to eq "<person>\n  <name>Jim</name>\n  <phone>555-1234</phone>\n</person>\n"
    }
  end
  
  context 'escaped' do
    pending 'write it'
  end
  
  context 'declare' do
    pending 'write it'
  end
end
