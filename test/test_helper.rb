# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Silence migrations and load schema to in-memory database
ActiveRecord::Migration.verbose = false
load "#{Rails.root}/db/schema.rb"

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

class GeneratorTestHelper < Rails::Generators::TestCase
  destination File.expand_path("../../tmp", __FILE__)

  setup :prepare_destination
  teardown :cleanup_destination

  private

  def cleanup_destination
    rm_rf(destination_root)
  end
end
