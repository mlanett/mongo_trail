RSpec.configure do |config|

  config.before( :each, :mongo => true ) do
    MongoTrail.configure do
      Mongo::Connection.new.db("test").collection("audit_trails").tap do |c|
        c.db.drop_collection( c.name)
      end
    end
  end

  config.after( :all, :mongo => true ) do
    MongoTrail.audit_trail_configuration.db.drop_collection( MongoTrail.audit_trail_configuration.name)
  end

end
