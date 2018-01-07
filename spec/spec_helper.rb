require 'simplecov'
SimpleCov.start

require 'bundler/setup'
Bundler.require :test

ROOT = Dir.pwd

$LOAD_PATH << File.join(ROOT, 'lib')
$LOAD_PATH << File.join(ROOT, 'lib', 'currency_converter')

require File.join ROOT, 'lib', 'archer.rb'
require File.join ROOT, 'lib', 'archer', 'utils.rb'

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
    mocks.allow_message_expectations_on_nil = true
  end

  config.order = :random

  config.expect_with :rspec do |c|
    c.syntax = :expect

    c.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
  end
end

def ostruct params
  OpenStruct.new params
end
