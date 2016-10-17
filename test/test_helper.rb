ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/rails/capybara'
require 'mocha/mini_test'

Dir[Rails.root.join('test', 'support', '*.rb')].each  { |file| require file }

# Checks for pending migrations before tests are run.
ActiveRecord::Migration.maintain_test_schema!

# Improved Minitest output (color and progress bar)
require 'minitest/reporters'
Minitest::Reporters.use!(
  Minitest::Reporters::ProgressReporter.new,
  ENV,
  Minitest.backtrace_filter)

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  include FactoryGirl::Syntax::Methods
  include AllTestHelper
  DatabaseCleaner.strategy = :truncation
  before { DatabaseCleaner.start }
  after  { DatabaseCleaner.clean } 
end

# Capybara
require 'capybara/rails'
class ActionDispatch::IntegrationTest
  extend MiniTest::Spec::DSL
  include Capybara::DSL
end

# Minitest Spec
class MiniTest::Spec
  include FactoryGirl::Syntax::Methods
  include AllTestHelper
end

class Capybara::Rails::TestCase
  include Rails.application.routes.url_helpers 
  include Capybara::DSL
  include Capybara::Assertions
  include IntegrationTestHelper
  include FactoryGirl::Syntax::Methods
  DatabaseCleaner.strategy = :truncation
  before { DatabaseCleaner.start }
  after  { DatabaseCleaner.clean } 
end