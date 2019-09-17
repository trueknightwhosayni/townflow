class String
  def to_bool
    ActiveRecord::Type::Boolean.new.cast(self)
  end
end

class NilClass
  def to_bool
    false
  end
end

class TrueClass
  def to_bool
    true
  end
end

class FalseClass
  def to_bool
    false
  end
end

class Integer
  def to_bool
    true
  end
end