require 'uri'
require 'sequel'
require 'dotenv'

if File.exists?('.env')
  Dotenv.load
elsif File.exists?('../.env')
  Dotenv.load('../.env')  # Migrations run at '$APP_ROOT/lib' level
else
  raise "Could not load running environment: #{ENV.inspect}"
end

DATABASE_URI = URI(ENV['DATABASE_URL'])
