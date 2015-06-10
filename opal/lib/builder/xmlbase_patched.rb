class Builder::XmlBase
  # This seemed to be causing problems
  XmlBase.cache_method_calls = false
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
