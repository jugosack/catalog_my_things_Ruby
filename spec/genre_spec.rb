require_relative '../classes/genre'
require_relative '../item'

describe Genre do
  before :each do
    @genre = Genre.new('rock')
  end

  context 'Genre should be an instance of Genre class' do
    it 'returns true' do
      expect(@genre).to be_an_instance_of(Genre)
    end
  end

  context 'Instance and should return the item passed into genre items array' do
    it 'returns true' do
      @item = Item.new('2000-10-20')
      @genre.add_item(@item)
      expect(@genre.items.length).to eq(1)
    end
  end
end
