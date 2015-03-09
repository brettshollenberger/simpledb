class AVLTree
  class NilNode
    class << self
      attr_accessor :key, :value, :left, :right

      def retrieve(key)
        nil
      end

      # creates new root
      def insert(key, value)
        AVLTree::Node.new(key: key, value: value)
      end

      def nil?
        true
      end
      
      def empty?
        true
      end

      def rotate
        self
      end

      def size
        0
      end

      def height
        0
      end

      def dump_sexp
      end
    end
  end
end
