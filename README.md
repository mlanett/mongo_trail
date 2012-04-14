# MongoTrail

Track audit trails in MongoDB.

A single document is created with an id given by you.
You can append simple records to it.
The document can be exported in a way that is easy to turn into CSV.

## Installation

Add this line to your application's Gemfile:

    gem 'mongo_trail'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongo_trail

## Usage

MongoTrail.record_audit_trail 1, "author" => "Mark Lanett", "gem" => "MongoTrail"
MongoTrail.record_audit_trail 1, "author" => "Mark Lanett", "gem" => "RedisLock"
MongoTrail.export_audit_trail(1).should have(2).items
MongoTrail.export_audit_trail(1).first.should include( "author" => "Mark Lanett", "gem" => "MongoTrail" )
MongoTrail.export_audit_trail(1).last.should include( "author" => "Mark Lanett", "gem" => "RedisLock" )

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
