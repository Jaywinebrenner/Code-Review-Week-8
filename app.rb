require('sinatra')
require('sinatra/reloader')
require('./lib/word')
require('pry')
also_reload('lib/**/*.rb')
require('./lib/definition')

word = Word.new("Nihilism", nil)
word.save
definition = Definition.new("The rejection of all religious and moral principles, in the belief that life is meaningless.", word.id, nil)
definition.save()

word2 = Word.new("Debauchery", nil)
word2.save
definition2 = Definition.new("Excessive indulgence in sensual pleasures.", word2.id, nil)
definition2.save()

word3 = Word.new("Totalitarianism", nil)
word3.save
definition3 = Definition.new("A system of government that is centralized and dictatorial and requires complete subservience to the state.", word3.id, nil)
definition3.save()



get('/') do
  @words = Word.all
  erb(:words)
end

get ('/words') do
  @words = Word.all
  erb(:words)
end

get('/words/new') do
  erb(:new_word)
end

post('/words') do

  name = params[:word_name]
  word = Word.new(name, nil)
  word.save()
  @words = Word.all()
  erb(:words)
end

get('/words/:id') do
  @word = Word.find(params[:id].to_i())
  erb(:word)
end

get('/words/:id/edit') do
@word = Word.find(params[:id].to_i())
erb(:edit_word)
end

patch('/words/:id') do
@word  = Word.find(params[:id].to_i())
@word.update(params[:name])
@words = Word.all
erb(:words)
end

delete('/words/:id') do
  @word = Word.find(params[:id].to_i())
  @word.delete()
  @words = Word.all
  erb(:words)
end

get('/words/:id/definitions/:definition_id') do
  @definition = Definition.find(params[:definition_id].to_i())
  erb(:definition)
end

post('/words/:id/definitions') do
  @word = Word.find(params[:id].to_i())
  definition = Definition.new(params[:definition_name], @word.id, nil)
  definition.save()
  erb(:word)
end

patch('/words/:id/definitions/:definition_id') do
  @word = Word.find(params[:id].to_i())
  definition = Definition.find(params[:definition_id].to_i())
  definition.update(params[:name], @word.id)
  erb(:word)
end

delete('/words/:id/definitions/:definition_id') do
  definition = Definition.find(params[:definition_id].to_i())
  definition.delete
  @word = Word.find(params[:id].to_i())
  erb(:word)
end
