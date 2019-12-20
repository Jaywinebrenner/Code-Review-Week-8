require 'rspec'
require 'word'

describe '#Word' do

  before(:each) do
    Word.clear()
    # Definition.clear()
  end


  describe('#==') do
      it("is the same word if it has the same attributes as another word") do
        word = Word.new("Nihilism", nil)
        word2 = Word.new("Nihilism", nil)
        expect(word).to(eq(word2))
      end
    end
end
