class Genre
  attr_accessor :name
  attr_reader :id, :items

  def initialize(name, id = '')
    @id = id.instance_of?(Integer) ? id : Random.rand(1..500)
    @name = name
    @items = []
  end

  def add_item(item)
    item.genre = self
    @items << item unless @items.include?(item)
  end
end
