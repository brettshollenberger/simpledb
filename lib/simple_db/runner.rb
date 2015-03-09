class SimpleDB
  class Runner
    attr_accessor :db

    def initialize(db)
      @db = db
    end

    def run
      $stdin.each_line do |line|
        input = line.split(" ")
        cmd   = input.first.downcase
        args  = input[1..-1]

        puts db.send(cmd, *args)
      end
    end
  end
end
