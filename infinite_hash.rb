class Hash
  def self.infinite
    self.new{|h, k| h[k] = self.new(&h.default_proc)}
  end

  def self.recursive max = nil
    if max && max.kind_of?(Fixnum)
      self.new{|h,k| h[k] = self.recursive(max-1) if max > 1}
    else
     infinite
    end
  end
end
