class Label
  attr_accessor :title, :color
  attr_reader :id, :items

  def initialize(title, color, id = '')
    @id = id.instance_of?(Integer) ? id : Random.rand(1..500)
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    item.label = self
    @items << item unless @items.include?(item)
  end
end