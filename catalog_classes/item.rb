require 'date'

class Item
  attr_accessor :genre, :author, :label, :publish_date, :archived
  attr_reader :id, :source

  def initialize(publish_date)
    @id = Random.rand(1..1000)
    @publish_date = publish_date
    @archived = false
  end

  def genre=(genre)
    @genre = genre
    genre.items << self unless genre.items.include?(self)
  end

  def author=(author)
    @author = author
    author.items << self unless author.items.include?(self)
  end

  def label=(label)
    @label = label
    label.items << self unless label.items.include?(self)
  end

  def source=(source)
    @source = source
    source.items << self unless source.items.include?(self)
  end

  def can_be_archived?
    published_year = Date.parse(publish_date).year
    current_year = Time.new.year
    current_year - published_year > 10
  end

  def move_to_archive
    @archived = true if can_be_archived
  end
end
