class SimpleDB
  class Transaction
    attr_accessor :db, :actions

    def initialize(db)
      @actions = []
      @db      = db
    end

    def push(action, *args)
      actions.push send(action, *args << db)
    end

    def empty?
      @actions.empty?
    end

    def set(*args)
      TransactionSet.new(*args)
    end

    def unset(*args)
      TransactionUnset.new(*args)
    end
  end
end
