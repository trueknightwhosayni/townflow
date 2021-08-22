class String
  def is_i?
    /\A[-+]?\d+\z/ === self
  end
end

class NilClass
  def is_i?
    false
  end
end

class TrueClass
  def is_i?
    false
  end
end

class FalseClass
  def is_i?
    false
  end
end

class Integer
  def is_i?
    true
  end
end
