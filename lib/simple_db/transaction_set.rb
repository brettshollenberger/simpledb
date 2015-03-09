class SimpleDB
  class TransactionSet
    attr_accessor :key, :value, :original_value, :db

    def initialize(key, value, db)
      @key            = key
      @value          = value
      @original_value = db.keys[key]
      @db             = db
    end

    def rollback
      if original_value.nil?
        db.unset(key)
      else
        db.set(key, original_value)
      end
    end
  end
end
