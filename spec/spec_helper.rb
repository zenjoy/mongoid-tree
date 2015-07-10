require 'rubygems'
require 'bundler/setup'

require 'mongoid'
require 'mongoid/tree'

require 'pry'
require 'byebug'
require 'rspec'

Mongoid.configure do |config|
  config.connect_to('mongoid_tree_test')
end

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  # Some speedup fixes
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.mock_with :rspec
  config.after(:each) { Mongoid.purge! }

  Mongo::Logger.logger.level = Logger::INFO
end
