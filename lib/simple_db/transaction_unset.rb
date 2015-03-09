class SimpleDB
  class TransactionUnset
    attr_accessor :key, :original_value, :db

    def initialize(key, db)
      @key            = key
      @original_value = db.keys[key]
      @db             = db
    end

    def rollback
      db.set(key, original_value)
    end
  end
end
