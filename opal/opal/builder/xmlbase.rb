require 'opal/builder/builder_mutable_string'
require 'opal/builder/builder_symbol'

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
