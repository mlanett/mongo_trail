# -*- encoding: utf-8 -*-
require "mongo_trail/version"
require "mongo"

module MongoTrail

  module Configuration
    attr :audit_trail_configuration
    def configure(&block)
      @audit_trail_configuration = yield
      @audit_trail_configuration.ensure_index( "id", unique: true )
    end
  end # Configuration

  # Document structure:
  # => id   Primary key (can't use _id due to limitations in upsert)
  # => keys Array of Strings
  # => data Array of Document
  module AuditTrail

    def record_audit_trail( id, data = {} )
      bkey = { id: id }
      keys = data.keys.sort
      audit_trail_configuration.update( bkey, { "$set" => bkey, "$addToSet" => { keys: { "$each" => keys } }, "$push" => { data: data } }, upsert: true )
    end

    # If a block is given, writes an array to the block line by line
    # Otherwise, returns an array.
    def export_audit_trail( id, &block )
      if ! block then
        return [].tap { |result| export_audit_trail( id ) { |row| result << row } }
      end

      bkey = { id: id }
      doc  = audit_trail_configuration.find( bkey ).to_a.first
      if doc then
        keys = doc["keys"].sort
        data = doc["data"]
        data.each { |row| block.call( row ) }
      end
    end

  end # AuditTrail

  extend Configuration
  extend AuditTrail
end
