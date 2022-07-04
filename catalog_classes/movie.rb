require_relative 'item'

class Movie < Item
  attr_accessor :silent

  def initialize(publish_date, silent)
    super(publish_date)
    @silent = false unless silent == 'N'
  end

  def can_be_archived?
    @silent || super
  end
end
