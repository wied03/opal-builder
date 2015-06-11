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
