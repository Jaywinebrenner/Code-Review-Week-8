require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe('create a word path', {:type => :feature}) do
  it('creates a word and then goes to the word page') do
    visit('/words')
    click_on('Add')
    fill_in('word_name', :with => 'Nihilism')
    click_on('Add Word')
    expect(page).to have_content('Nihilism')
  end
end

describe('create a definition path', {:type => :feature}) do
  it('creates a word and then goes to the word page') do
    word = Word.new("Debauchery", nil)
    word.save
    visit("/words/#{word.id}")
    fill_in('definition_name', :with => 'excessive indulgence in sensual pleasures.')
    click_on('Add definition')
    expect(page).to have_content('excessive indulgence in sensual pleasures.')
  end
end


describe('delete a word', {:type => :feature}) do
  it('deletes a word') do
    visit('/words')
    click_on('Add')
    fill_in('word_name', :with => 'Tooth')
    click_on('Add Word')
    click_on('Tooth')
    click_on('Edit Word')
    click_on('Delete word')
    expect(page).to have_no_content("Tooth")
  end
end


# Unable to find link or button "Delete definition"
describe('delete a definition', {:type => :feature}) do
  it('deletes a definition') do
    visit('/words')
    click_on('Nihilism')
    visit("/words/1/definition/1")
    click_on('Delete definition')
    click_on("Nihilism")
    expect(page).to have_no_content("The rejection of all religious and moral principles, in the belief that life is meaningless.")
  end
end


# unable to find definition name
describe('Update', {:type => :feature}) do
  it('will navigate to the update definition page and change the definition') do
    visit('/words')
    click_on('Nihilism')
    visit('/words/1/definition/1')
    fill_in('definition_name', :with => 'Party Time')
    click_on('Update Definition')
    expect(page).to have_content("Party Time")
  end
end
