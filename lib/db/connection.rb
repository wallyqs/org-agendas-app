$LOAD_PATH << File.dirname(__FILE__)
require 'lib/environment'
DB = Sequel.connect(ENV['DATABASE_URL'])
