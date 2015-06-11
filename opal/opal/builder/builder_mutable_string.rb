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
