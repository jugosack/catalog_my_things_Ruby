class Genre
  attr_reader :id, :name, :items

  def initialize(id, name)
    @id = id || (Random.rand(1..1000) + Random.rand(1..1000))
    @name = name
    @items = []
  end

  def add_item(item)
    item.genre = self
    @items << item unless @items.include?(item)
  end
end
