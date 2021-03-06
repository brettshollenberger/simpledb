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

    expect(db.get "hello").to eq "NULL"
  end

  it "prints num keys currently set to a given value" do
    db.set "hello", "world"
    db.set "goodbye", "world"

    expect(db.numequalto "world").to eq 2
  end

  it "creates transactions & rolls back" do
    db.begin
    expect(db.transactions.count).to eq 1

    db.set "hello", "world"

    expect(db.get "hello").to eq "world"

    db.rollback

    expect(db.get "hello").to eq "NULL"
  end

  it "nests transactions, and only rolls back the most recent one" do
    db.begin
    db.set "hello", "world"
    db.begin
    db.set "goodbye", "world"

    expect(db.get "hello").to eq "world"
    expect(db.get "goodbye").to eq "world"

    db.rollback

    expect(db.get "hello").to eq "world"
    expect(db.get "goodbye").to eq "NULL"

    db.rollback

    expect(db.get "hello").to eq "NULL"
    expect(db.get "goodbye").to eq "NULL"
  end

  it "commits all changes from all open transactions" do
    db.begin
    db.set "hello", "world"
    db.begin
    db.set "goodbye", "world"
    db.commit

    expect(db.transactions.length).to be 0
    expect(db.get "hello").to eq "world"
    expect(db.get "goodbye").to eq "world"
  end

  it "rollsback unset" do
    db.set "hello", "world"

    db.begin
    db.unset "hello"

    expect(db.get "hello").to eq "NULL"

    db.rollback

    expect(db.get "hello").to eq "world"
  end

  it "rolls back actions in reverse order" do
    db.set "hello", "world"
    db.begin
    db.set "hello", "brett"
    db.set "hello", "shalom"
    db.rollback

    expect(db.get "hello").to eq "world"
  end

  it "tracks the number of values set with transactions" do
    db.set "hello", "world"
    db.begin
    db.set "goodbye", "world"

    expect(db.numequalto "world").to eq 2
    db.rollback

    expect(db.numequalto "world").to eq 1
  end
end
