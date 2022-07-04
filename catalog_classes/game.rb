require_relative "./item"
require 'date'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(published_date, multiplayer, last_played_at)
    super(publish_date)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    last_year = Date.parse(@last_played_at).year
    current_year = Time.new.year
    super || current_year - last_year > 2
  end
end
