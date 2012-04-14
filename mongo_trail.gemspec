# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mongo_trail/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mark Lanett"]
  gem.email         = ["mark.lanett@gmail.com"]
  gem.summary       = %q{Track audit trails in MongoDB}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mongo_trail"
  gem.require_paths = ["lib"]
  gem.version       = MongoTrail::VERSION

  gem.add_dependency "mongo"
end
