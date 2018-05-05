require 'sinatra'

after do
  response['Date'] = Time.now.httpdate
end

get '/' do
  # do nothing
end

get '/user/:id' do |id|
  body id.to_s
end

post '/user' do
  # do nothing
end
