require 'lib/environment'
DB = Sequel.connect(ENV['DATABASE_URL'])
