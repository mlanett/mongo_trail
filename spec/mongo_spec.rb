require "helper"

describe Mongo do

  subject { Mongo::Connection.new.db("test").collection("test") }
  before { subject.db.drop_collection( subject.name) }
  after  { subject.db.drop_collection( subject.name) }

  it "can insert" do
    subject.insert( { "a" => 1, "b" => 2 } )
    subject.find.count.should == 1
  end

  it "can find" do
    subject.insert( { "a" => 1, "b" => 2 } )
    subject.insert( { "a" => 3, "b" => 4 } )
    subject.find({ "a" => 3 }).first.should include({ "b" => 4 })
  end

  it "can update" do
    subject.update( { id: 1 }, { id: 1, fields: [], changes: [] }, upsert: true )
    subject.find({ id: 1 }).find.count.should == 1

    # update can't mix modifiers and regular values, so must $set the keys
    # update can't modify and set _id (as of 2.2)
    subject.update( { id: 1 }, { "$set" => { id: 1 }, "$inc" => { magic: 1 }, "$addToSet" => { foo: "bar" } }, upsert: true, safe: true )
    subject.update( { id: 1 }, { "$set" => { id: 1 }, "$inc" => { magic: 1 }, "$addToSet" => { foo: { "$each" => [ "zap", "zip" ] } } }, upsert: true )
    subject.find({ id: 1 }).find.count.should == 1
    subject.find({ id: 1 }).find.first.should include({ "foo" => [ "bar", "zap", "zip" ] })
  end

  it "can not upsert and set custom _id" do
    expect { subject.update( { _id: 1 }, { "$set" => { _id: 1 } }, upsert: true, safe: true ) }.to raise_exception
    expect { subject.update( { _id: 1 }, { "$iset" => { _id: 1 } }, upsert: true, safe: true ) }.to raise_exception
  end

  it "finds nothing as empty array" do
    subject.find( foo: 1 ).to_a.should == []
  end

end
