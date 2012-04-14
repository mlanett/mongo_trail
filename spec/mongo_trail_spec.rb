require "helper"

describe MongoTrail, mongo: true do

  it "exports empty audit trails for unknown objects" do
    MongoTrail.export_audit_trail(1).should have(0).items
  end

  it "can record and export audit trails" do
    MongoTrail.record_audit_trail 1, "author" => "Mark Lanett", "gem" => "MongoTrail"
    MongoTrail.record_audit_trail 1, "author" => "Mark Lanett", "gem" => "RedisLock"
    MongoTrail.export_audit_trail(1).should have(2).items
    MongoTrail.export_audit_trail(1).first.should include( "author" => "Mark Lanett", "gem" => "MongoTrail" )
    MongoTrail.export_audit_trail(1).last.should include( "author" => "Mark Lanett", "gem" => "RedisLock" )
    puts MongoTrail.audit_trail_configuration.find.to_a
  end

  it "normalizes data with all keys in use" do
    MongoTrail.record_audit_trail 1, "author" => "Mark Lanett", "gem" => "MongoTrail"
    MongoTrail.record_audit_trail 1, "author" => "Mark Lanett"
    # expect all documents to have author and gem
    MongoTrail.export_audit_trail(1).last.should include( "author" => "Mark Lanett", "gem" => nil )
  end

end
