class AVLTree
  class Node
    attr_accessor :key, :value, :left, :right, :height

    def initialize(options={})
      @key    = options.fetch(:key)
      @value  = options.fetch(:value)
      @left   = NilNode
      @right  = NilNode
      @height = 1
    end

    def retrieve(key)
      if key < @key
        @left.retrieve(key)
      elsif key > @key
        @right.retrieve(key)
      elsif key == @key
        @value
      else
        nil
      end
    end

    def insert(key, value)
      if key < @key
        @left = @left.insert(key, value)
      elsif key > @key
        @right = @right.insert(key, value)
      elsif key == @key
        @value = value
      end

      rotate
    end

    def delete(key)
      if key < @key
        deleted, @left = @left.delete(key)
        [deleted, self.rotate]
      elsif key > @key
        deleted, @right = @right.delete(key)
        [deleted, self.rotate]
      elsif key == @key
        [self, delete_self.rotate]
      end
    end

    def delete_self
      if @left.empty? and @right.empty?
        deleted = NilNode
      elsif @right.height < @left.height
        deleted, new_left = @left.delete_max
        deleted.left, deleted.right = new_left, @right
      else
        deleted, new_right = @right.delete_min
        deleted.left, deleted.right = @left, new_right
      end
      deleted
    end

    def delete_min
      if @left.empty?
        [self, delete_self]
      else
        deleted, @left = @left.delete_min
        [deleted, rotate]
      end
    end

    def delete_max
      if @right.empty?
        [self, delete_self]
      else
        deleted, @right = @right.delete_max
        [deleted, rotate]
      end
    end

    def rotate
      case @left.height - @right.height
      when +2
        if @left.left.height < @left.right.height
          @left = @left.rotate_left
        end
        root = rotate_right
      when -2
        if @right.left.height > @right.right.height
          @right = @right.rotate_right
        end
        root = rotate_left
      else
        root = self
      end
      root.update_height
      root
    end

    def rotate_left
      root = @right
      @right = root.left
      root.left = self
      root.left.update_height
      root
    end

    def rotate_right
      root = @left
      @left = root.right
      root.right = self
      root.right.update_height
      root
    end

    def update_height
      @height = (@left.height > @right.height ? @left.height : @right.height) + 1
    end

    def empty?
      false
    end

    def dump_sexp
      left  = @left.dump_sexp
      right = @right.dump_sexp
      if left or right
        '(' + [@key, left || '-', right].compact.join(' ') + ')'
      else
        @key
      end
    end
  end
end
