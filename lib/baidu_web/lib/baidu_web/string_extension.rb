module StringExtension
  def blank?
    self.nil? || self.strip.length == 0
  end
end

String.send :include, StringExtension
NilClass.send :include, StringExtension
