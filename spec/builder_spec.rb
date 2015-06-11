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
  
  context 'attributes' do
    subject { builder.sample escaped: input[0], unescaped: input[1] }
    
    context 'normal' do
      let(:input) { ['This and That', 'Here and There' ]}
    
      it { 
        is_expected.to eq '<sample escaped="This and That" unescaped="Here and There"/>'
      }
    end
    
    context 'xml entities' do
      context 'amp' do
        let(:input) { ['This&That', 'Here&amp;There' ]}
    
        it { 
          is_expected.to eq '<sample escaped="This&amp;That" unescaped="Here&amp;There"/>'
        }
      end
      
      context 'lt' do
        let(:input) { ['This<That', 'Here&lt;There' ]}
        
        it { 
          is_expected.to eq '<sample escaped="This&lt;That" unescaped="Here&lt;There"/>'
        }
      end
      
      context 'gt' do
        pending 'write it'
      end
      
      context 'apos' do
        pending 'write it'
      end
    end   
    
    context 'quotes' do
      subject {
        builder.sample escaped: 'This"That'
      }
    
      it { 
        is_expected.to eq '<sample escaped="This&quot;That"/>'
      }
    end
    
    context 'line feed' do
      subject {
        builder.sample escaped: "This\nThat"
      }
    
      it { 
        is_expected.to eq '<sample escaped="This&#10;That"/>'
      }
    end
    
    context 'carriage return' do
      subject {
        builder.sample escaped: "This\rThat"
      }
    
      it { 
        is_expected.to eq '<sample escaped="This&#13;That"/>'
      }
    end
  end
  
  # TODO: more when symbol logic there
  context 'declare' do
    pending 'write it'
  end
end
