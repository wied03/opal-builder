require 'opal/builder/builder_mutable_string'
require 'opal/builder/builder_symbol'

class Builder::XmlMarkup
  # Try and avoid a bunch of string mutation changes
  def initialize(options={})
    indent = options[:indent] || 0
    margin = options[:margin] || 0
    @quote = (options[:quote] == :single) ? "'" : '"'
    @explicit_nil_handling = options[:explicit_nil_handling]
    super(indent, margin)
    @target = options[:target] || BuilderMutableString.new("")    
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
  
  def declare!(inst, *args, &block)
    ::Kernel.raise 'declare! is not currently supported on Opal because symbols cannot be detected easily.'
  end
end
