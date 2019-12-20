require('sinatra')
require('sinatra/reloader')
require('./lib/stage')
require('pry')
also_reload('lib/**/*.rb')
require('./lib/definition')


get('/') do
  @words = Word.all
  erb(:words)
end
