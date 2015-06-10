class Builder::XmlBase
  # This seemed to be causing problems
  XmlBase.cache_method_calls = false
  
  def non_string_mutating_original_tag!(sym, *args, &block)
    text = nil
    attrs = nil
    sym = "#{sym}:#{args.shift}" if args.first.kind_of?(::Symbol)
    sym = sym.to_sym unless sym.class == ::Symbol
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
  
  def tag!(sym, *args, &block)
    # Opal splat issues
    if args.length == 0
      non_string_mutating_original_tag! sym, *args, &block
    else
      non_string_mutating_original_tag! sym, args, &block
    end    
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
