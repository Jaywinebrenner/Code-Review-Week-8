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
    visit('/words')
    click_on('Nihilism')
    fill_in('definition_name', :with => 'The rejection of all religious and moral principles, in the belief that life is meaningless.')
    click_on('Add definition')
    expect(page).to have_content('The rejection of all religious and moral principles, in the belief that life is meaningless.')
  end
end

describe('delete a word', {:type => :feature}) do
  it('will delete a word') do
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

describe('delete a definition', {:type => :feature}) do
  it('will delete a definition') do
    visit('/words')
    click_on('Nihilism')
    click_on('The rejection of all religious and moral principles, in the belief that life is meaningless.')
    click_on('Delete definition')
    expect(page).to have_no_content("The rejection of all religious and moral principles, in the belief that life is meaningless.")
  end
end

describe('Update', {:type => :feature}) do
  it('will navigate to the update definition page and change the definition') do
    word = Word.new("Fish Breath", nil)
    word.save
    definition = Definition.new("Liquid gas and good times.", word.id, nil)
    definition.save
    visit('/words')
    click_on('Fish Breath')
    click_on('Liquid gas and good times.')
    fill_in('name', :with => 'Solid gas and an okay time.')
    click_on('Update')
    # binding.pry
    expect(page).to have_content("Solid gas and an okay time.")
  end
end
