# -*- encoding: utf-8 -*-
require "mongo_trail/version"
require "mongo"

module MongoTrail

  module Configuration
    attr :audit_trail_configuration
    def configure(&block)
      @audit_trail_configuration = yield
      @audit_trail_configuration.ensure_index( [ [ "type", Mongo::ASCENDING ], [ "id", Mongo::ASCENDING ] ], unique: true )
    end
  end # Configuration

  extend Configuration
end
