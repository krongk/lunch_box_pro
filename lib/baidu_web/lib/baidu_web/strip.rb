class Object
  def strip
    self.class == String && !self.nil? ? super : self
  end
end
