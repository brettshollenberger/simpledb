class SimpleDB
  def initialize
    @keys   = AVLTree.new
    @values = AVLTree.new
  end

  def set(key, value)
    decrease_value_of_key(key)
    set_key(key, value)
    increase_value(value)
  end

  def get(key)
    @keys[key]
  end

  def numequalto(value)
    @values[value] || 0
  end

  def unset(key)
    @keys.delete(key)
  end

private
  def set_key(key, value)
    @keys[key] = value
  end

  def decrease_value_of_key(key)
    value = @keys[key]
    v     = @values[value] unless value.nil?

    unless v.nil?
      @values[value] -= 1
    end
  end

  def increase_value(value)
    v = @values[value]

    if v.nil?
      @values[value] = 1
    else
      @values[value] += 1
    end
  end
end
