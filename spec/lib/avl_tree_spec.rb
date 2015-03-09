require "spec_helper"

describe AVLTree do
  let(:tree) { AVLTree.new }

  it "initializes tree with NilNode root" do
    expect(tree.root).to eq AVLTree::NilNode
  end

  it "is empty" do
    expect(tree).to be_empty
  end

  it "is size zero" do
    expect(tree.size).to be 0
  end

  it "inserts nodes" do
    tree["a"] = 1

    expect(tree.root.value).to eq 1
  end

  it "inserts subnodes" do
    tree["a"] = 1
    tree["b"] = 2

    expect(tree.root.right.key).to eq "b"
  end

  it "rotates left when height of right tree is +2 than left tree" do
    tree["a"] = 1
    tree["b"] = 2
    tree["c"] = 3

    expect(tree.root.key).to eq "b"
  end

  it "rotates right when height of left tree is +2 than right tree" do
    tree["c"] = 3
    tree["b"] = 2
    tree["a"] = 1

    expect(tree.root.key).to eq "b"
  end

  it "retrieves values" do
    tree["c"] = 3
    tree["b"] = 2
    tree["a"] = 1

    expect(tree["b"]).to eq 2
  end

  it "retrieves nil if unset" do
    expect(tree["a"]).to be nil
  end

  it "deletes keys" do
    tree["a"] = 1

    expect(tree.delete "a").to eq 1
    expect(tree.root).to be AVLTree::NilNode
  end
end
