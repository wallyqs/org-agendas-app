require 'sinatra'
require 'org-ruby'
require 'erb'
require 'lib/db/connection'
require 'lib/db/models'
$stdout.sync = true

get '/' do
  @texts = Agenda.all

  erb :texts
end


get '/agendas/:name.?:format?' do
  @org = Agenda.where(:name => params[:name]).first
  erb :text
end

get "/api/v1/agendas/:name.?:format?" do
  agenda = Agenda.where(:name => params[:name]).all
  org_content = agenda.inject('') do |merged_content, org|
    merged_content += org.values[:content]
  end

  case params[:format]
  when 'html'
    content_type 'text/html'
    Orgmode::Parser.new(org_content).to_html
  when 'json'
    content_type 'application/json'
    '{"status": "TBD" }'
  else
    content_type 'text/plain'
    org_content
  end
end


put "/api/v1/agendas/:name.?:format?" do
  body = request.body.read

  org = nil
  begin
    org = Orgmode::Parser.new(body)
  rescue => e
    puts "Error during parsing: "
    puts e
    halt 500
  end

  begin
    t = Agenda.where(:name => params[:name]).first || Agenda.new(:name => params[:name])
    t.title   ||= org.in_buffer_settings['TITLE']
    t.content ||= body
    t.save
  rescue => e
    puts e
    puts e.backtrace
    puts e.backtrace.join("\n")
    halt 500
  end

  200
end

