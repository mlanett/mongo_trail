guard "rspec" do
  watch("lib/mongo_trail.rb")           { "spec" }
  watch(%r{^lib/mongo_trail/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^spec/.+_spec\.rb$})
  watch("spec/helper.rb")               { "spec" }
end
