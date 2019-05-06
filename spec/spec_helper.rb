require 'bundler/setup'

Bundler.require(:default, :test)
#require (Pathname.new(__FILE__).dirname + '../lib/suspenders').expand_path


# these are from work
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'minitest/spec'
require 'rspec/rails'
#require 'devise'
#require 'database_cleaner'
#require 'capybara/rails'
#require 'capybara/rspec'
# end are fron work


Dir['./spec/support/**/*.rb'].each { |file| require file }

RSpec.configure do |config|
  #config.include SuspendersTestHelpers
  #config.include ProjectFiles

  config.before(:all) do
    #add_fakes_to_path
    #create_tmp_directory
  end

  config.before(:each) do
    #FakeGithub.clear!
  end


  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
