class SimpleDB
  NO_TRANSACTION = "NO TRANSACTION"

  attr_accessor :transactions, :keys, :values

  def initialize
    @keys         = AVLTree.new
    @values       = AVLTree.new
    @transactions = []
  end

  def set(key, value)
    log_transaction("set", key, value)
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

  def begin
    @transactions.push(Transaction.new(self))
  end

  def rollback
    if @transactions.empty?
      NO_TRANSACTION
    else
      @transactions.last.actions.each(&:rollback)
      @transactions.pop
    end
  end

  def commit
    if @transactions.empty?
      NO_TRANSACTION
    else
      @transactions = []
    end
  end

private
  def log_transaction(action, *args)
    unless @transactions.last.nil?
      @transactions.last.push(action, *args)
    end
  end

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
