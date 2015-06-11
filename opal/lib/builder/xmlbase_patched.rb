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
  
  # Not supporting escaping, but do need to ensure we're using mutable strings
  def _escape(text)
    ensure_mutable = text.is_a?(BuilderMutableString) ? text : BuilderMutableString.new(text)
    ensure_mutable.to_xs
  end
end

class BuilderMutableString  
  def initialize(str)
    @state = str
  end
  
  def <<(text)
    @state += text
    self
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
  
  # Unpack doesn't exist in Opal
  def to_xs
    gsub(/&(?!\w+;)/, '&amp;')
    .gsub(/</, '&lt;')
    .gsub(/>/, '&gt;')
    .gsub(/'/, '&apos;')
  end
  
  def gsub(regex, replace)
    @state = @state.gsub regex,replace
    self
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
  
  # all strings will be symbols, so we have to change the case statement
  def _attr_value(value)
    case value
    when ::BuilderSymbol
      value.to_s
    else
      _escape_attribute(value.to_s)
    end
  end
end
