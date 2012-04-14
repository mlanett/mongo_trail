source 'https://rubygems.org'

# Specify your gem's dependencies in mongo_trail.gemspec
gemspec

group :development, :test do
  gem "bson_ext",       require: false
  gem "guard-rspec"
  gem "rake"
  gem "rb-fsevent"      # for guard
  gem "rspec"
  gem "ruby_gntp"       # for guard
end

group :test do
  gem "ruby-debug19",   require: false
  gem "simplecov",      require: false
  #em "plymouth"        # invoke pry after rspec failures
end
