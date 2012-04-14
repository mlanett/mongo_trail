require "helper"

describe MongoTrail::Configuration do

  it "can be configured" do
    MongoTrail.configure { Mongo::Connection.new.db("test").collection("audit_trails") }
    MongoTrail.audit_trail_configuration.should be_an_instance_of(Mongo::Collection)
  end

end
