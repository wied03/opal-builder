require 'builder'

describe Builder::XmlMarkup do
  let(:options) { {} }
  let(:target) { nil }
  let(:builder) { 
    args = options
    args[:target] = target if target
    Builder::XmlMarkup.new args 
  }  
  
  RSpec::Matchers.define :produce_xml do |expected_xml|
    def get_xml(actual)
      if target
        raise "Expected subject to be a #{target.class} object but was a #{actual.class}" unless actual.class == target.class
        actual.string
      else
        # Deal with string mutation class
        actual.to_s
      end
    end
    
    match do |actual_xml|
      get_xml(actual) == expected_xml
    end
    
    failure_message do |actual_xml|
      "Expected '#{expected_xml}' but got '#{get_xml(actual)}'"
    end
  end
  
  RSpec.shared_context :examples do
    context 'basic case' do
      subject { builder.person { |b| b.name("Jim"); b.phone("555-1234") } }    

      it { is_expected.to produce_xml '<person><name>Jim</name><phone>555-1234</phone></person>' }
    end  
  
    context 'indent' do
      let(:options) { {indent: 2}}
      subject { builder.person { |b| b.name("Jim"); b.phone("555-1234") } }   
    
      it { 
        is_expected.to produce_xml "<person>\n  <name>Jim</name>\n  <phone>555-1234</phone>\n</person>\n"
      }
    end
  
    describe 'attributes' do
      subject { builder.sample escaped: input[0], unescaped: input[1] }
    
      context 'normal' do
        let(:input) { ['This and That', 'Here and There' ]}
    
        it { 
          is_expected.to produce_xml '<sample escaped="This and That" unescaped="Here and There"/>'
        }
      end
    
      context 'xml entities' do
        context 'amp' do
          let(:input) { ['This&That', 'Here&amp;There' ]}
    
          it { 
            is_expected.to produce_xml '<sample escaped="This&amp;That" unescaped="Here&amp;There"/>'
          }
        end
      
        context 'lt' do
          let(:input) { ['This<That', 'Here&lt;There' ]}
        
          it { 
            is_expected.to produce_xml '<sample escaped="This&lt;That" unescaped="Here&lt;There"/>'
          }
        end
      
        context 'gt' do
          let(:input) { ['This>That', 'Here&gt;There' ]}
        
          it { 
            is_expected.to produce_xml '<sample escaped="This&gt;That" unescaped="Here&gt;There"/>'
          }        
        end
      
        context 'apos' do
          let(:input) { ["This'That", 'Here&apos;There' ]}
        
          it { 
            is_expected.to produce_xml '<sample escaped="This&apos;That" unescaped="Here&apos;There"/>'
          }  
        end
      end   
    
      context 'quotes' do
        subject {
          builder.sample escaped: 'This"That'
        }
    
        it { 
          is_expected.to produce_xml '<sample escaped="This&quot;That"/>'
        }
      end
    
      context 'line feed' do
        subject {
          builder.sample escaped: "This\nThat"
        }
    
        it { 
          is_expected.to produce_xml '<sample escaped="This&#10;That"/>'
        }
      end
    
      context 'carriage return' do
        subject {
          builder.sample escaped: "This\rThat"
        }
    
        it { 
          is_expected.to produce_xml '<sample escaped="This&#13;That"/>'
        }
      end
    end
  
    describe '#comment!' do
      # indent required for some reason (see builder source)
      let(:options) { {indent: 1}}
    
      subject { builder.comment! 'This is a comment' }
    
      it { 
        is_expected.to produce_xml "<!-- This is a comment -->\n"
      }
    end
  
    describe '#instruct!' do
      # indent required for some reason (see builder source)
      let(:options) { {indent: 1}}
    
      subject { builder.instruct! :xml, version: '1.0', encoding: 'UTF-8' }
    
      it { 
        is_expected.to produce_xml '<?xml version="1.0" encoding="UTF-8"?>'"\n"
      }
    end  

    describe 'declare!' do   
      subject { lambda { builder.declare! :DOCTYPE, :chapter, :SYSTEM, "../dtds/chapter.dtd" } }
    
      it { 
        is_expected.to raise_exception 'declare! is not currently supported on Opal because symbols cannot be detected easily.'
      }
    end    
  end
  
  context 'default output' do
    include_context :examples
  end
  
  context 'StringIO output' do    
    let(:target) { StringIO.new }
    
    include_context :examples
  end 
end
