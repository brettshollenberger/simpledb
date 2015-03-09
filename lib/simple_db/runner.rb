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

        begin
          puts db.send(cmd, *args)
        rescue
          puts "Invalid input. Try again."
        end
      end
    end
  end
end
