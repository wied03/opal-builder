class Builder::XmlBase  
  def method_missing(sym, *args, &block)
    # Omitting cache_method_calls because it causes problems
    
    # Code in tag cares whether things are actually symbols and method names should be, so "create" them
    tag!(BuilderSymbol.new(sym), *args, &block)
  end
  
  def tag!(sym, *args, &block)
    text = nil
    attrs = nil
    sym = "#{sym}:#{args.shift}" if args.first.kind_of?(::BuilderSymbol)
    unless sym.class == ::BuilderSymbol
      riase "not sure how to convert sym, which is class #{sym.class} and value #{sym} to a symbol"
    end
    sym = sym.to_sym unless sym.class == ::BuilderSymbol
    args.each do |arg|
      case arg
      when ::Hash
        attrs ||= {}
        attrs.merge!(arg)
      when nil
        attrs ||= {}
        attrs.merge!({:nil => true}) if explicit_nil_handling?
      else
        # Changed this from text ||= ''
        text ||= BuilderMutableString.new ''
        text << arg.to_s
      end
    end
    if block
      unless text.nil?
        ::Kernel::raise ::ArgumentError,
          "XmlMarkup cannot mix a text argument with a block"
      end
      _indent
      _start_tag(sym, attrs)
      _newline
      begin
        _nested_structures(block)
      ensure
        _indent
        _end_tag(sym)
        _newline
      end
    elsif text.nil?
      _indent
      _start_tag(sym, attrs, true)
      _newline
    else
      _indent
      _start_tag(sym, attrs)
      text! text
      _end_tag(sym)
      _newline
    end
    @target
  end 
end

class BuilderMutableString  
  def initialize(str)
    @state = str
  end
  
  def <<(text)
    @state += text    
  end
  
  def to_s
    @state
  end
  
  def to_str
    @state
  end
  
  def nil?
    @state.nil?
  end
  
  def to_xs
    @state
  end
  
  def unpack(format)
    @state.unpack format
  end
  
  def ==(other_str)
    @state == other_str
  end
end

# In Opal, symbols and strings are the same, builder differentiates
class BuilderSymbol
  def initialize(str)
    @symbol = str
  end
  
  def to_s
    @symbol
  end
  
  def to_str
    @symbol
  end
end

class Builder::XmlMarkup
  # Try and avoid a bunch of string mutation changes
  def initialize(options={})
    indent = options[:indent] || 0
    margin = options[:margin] || 0
    @quote = (options[:quote] == :single) ? "'" : '"'
    @explicit_nil_handling = options[:explicit_nil_handling]
    super(indent, margin)
    @target = BuilderMutableString.new(options[:target] || "")
  end
  
    
end
