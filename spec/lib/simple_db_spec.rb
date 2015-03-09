require "spec_helper"

describe SimpleDB do
  let(:db) { SimpleDB.new }

  it "sets & gets keys" do
    db.set "hello", "world"

    expect(db.get "hello").to eq "world"
  end

  it "unsets keys" do
    db.set "hello", "world"
    db.unset "hello"

    expect(db.get "hello").to be nil
  end

  it "prints num keys currently set to a given value" do
    db.set "hello", "world"
    db.set "goodbye", "world"

    expect(db.numequalto "world").to eq 2
  end

  it "creates transactions" do
    db.begin
    expect(db.transactions.count).to eq 1
  end
end
