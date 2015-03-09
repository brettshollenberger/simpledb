require "spec_helper"

describe AVLTree::Node do
  before(:each) do
    @node = AVLTree::Node.new(key: "a", value: 1)
  end

  it "represents a key-value pair in a binary search tree" do

    expect(@node.key).to eq  "a"
    expect(@node.value).to eq 1
  end

  it "initializes left & right to NilNode" do
    expect(@node.left).to  eq AVLTree::NilNode
    expect(@node.right).to eq AVLTree::NilNode
  end

  it "initializes height to 1" do
    expect(@node.height).to eq 1
  end
end
