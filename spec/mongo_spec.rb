require "helper"

describe Mongo do

  subject { Mongo::Connection.new.db("test").collection("audit_trails") }
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
    subject.update( { type: "X", id: 1 }, { type: "X", id: 1, fields: [], changes: [] }, upsert: true )
    subject.find({ type: "X", id: 1 }).find.count.should == 1

    # update can't mix modifiers and regular values, so must $set the keys
    subject.update( { type: "X", id: 1 }, { "$set" => { type: "X", id: 1 }, "$inc" => { magic: 1 }, "$addToSet" => { foo: "bar" } }, upsert: true )
    subject.update( { type: "X", id: 1 }, { "$set" => { type: "X", id: 1 }, "$inc" => { magic: 1 }, "$addToSet" => { foo: { "$each" => [ "zap", "zip" ] } } }, upsert: true )
    subject.find({ type: "X", id: 1 }).find.count.should == 1
    subject.find({ type: "X", id: 1 }).find.first.should include({ "foo" => [ "bar", "zap", "zip" ] })
  end

  it "finds nothing as empty array" do
    subject.find( foo: 1 ).to_a.should == []
  end

end
