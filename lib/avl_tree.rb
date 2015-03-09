class AVLTree
  include Enumerable

  attr_accessor :root

  def initialize
    @root = NilNode
  end

  def empty?
    @root == NilNode
  end
  
  def size
    @root.size
  end
  alias length size

  def []=(key, value)
    @root = @root.insert(key, value)
  end

  def [](key)
    @root.retrieve(key)
  end

  def delete(key)
    deleted, @root = @root.delete(key)
    deleted.value
  end

  # empty if tree is empty
  def dump_sexp
    @root.dump_sexp || ""
  end
end
