# -*- encoding: utf-8 -*-
require "bundler/setup"         # set up gem paths
require "ruby-debug"
require "simplecov"             # code coverage
SimpleCov.start                 # must be loaded before our own code
require "mongo_trail"           # load this gem

RSpec.configure do |spec|
  #
end
