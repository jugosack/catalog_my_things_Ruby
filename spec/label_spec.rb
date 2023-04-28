require_relative '../classes/label'
require_relative '../item'

describe Label do
  before :each do
    @label = Label.new('new', 'green')
  end

  context '#new' do
    it 'accepts (2) parameters and returns an instance of Label' do
      expect(@label).to be_an_instance_of(Label)
    end
  end

  context '#add_item' do
    it 'takes an instance of item and add it to the collection of items' do
      @item = Item.new(23, '2010-1-15')
      @label.add_item(@item)
      expect(@label.items.length).to eq(1)
      expect(@item.label).to be_an_instance_of(Label)
    end
  end
end
