require 'uri'
require 'sequel'
require 'dotenv'

begin
  if File.exists?('.env')
    Dotenv.load
  elsif File.exists?('../.env')
    Dotenv.load('../.env')  # Migrations run at '$APP_ROOT/lib' level
  end
rescue
  # skip
end

DATABASE_URI = URI(ENV['DATABASE_URL'])
