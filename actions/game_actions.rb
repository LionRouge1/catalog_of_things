require './catalog_classes/game'
require './json/json_manipulation'
require './modules/source_module'
require './modules/genre_module'
require './modules/label_module'
require './modules/author_module'

class GameActions
  attr_accessor :games

  def initialize
    readjson = Manipulation.new
    @games = readjson.read_data('games.json') || []
  end

  include SourceModule
  include GenreModule
  include AuthorModule
  include LabelModule
  
  def add_game
    add_source
    add_genre
    add_label
    add_author

    print 'Publish date in format [d/mm/YYYY]: '
    publish_date = gets.chomp
    print 'nombre of player: '
    multiplayer = gets.chomp.to_i
    print 'Last played at [d/mm/yyyy]: '
    last_played = gets.chomp
    game = Game.new(publish_date, multiplayer, last_played)
    @source.add_item(game)
    @genre.add_item(game)
    @label.add_item(game)
    @author.add_item(game)
    game_obj = { id: game.id, author: [game.author.first_name, game.author.last_name], 
                  source: game.source.name, label: [game.label.title, game.label.color], 
                  genre: game.genre.name, publish_date: game.publish_date, multiplayer: game.multiplayer, 
                  last_played: game.last_played_at }
    @games << game_obj unless @games.include?(game_obj)
    puts 'game successfully created'
  end

  def list_all_games
    @games.map do |game|
      puts "ID: #{game[:id]}
        Author full name: #{game[:author][0]} #{game[:author][1]}
        Source: #{game[:source]}
        Label title: #{game[:label][0]} Color: #{game[:label][1]}
        Publish date: #{game[:publish_date]}
        Nomber of player: #{game[:multiplayer]}
        Last played: #{game[:last_played]}"
      puts ''
    end
  end
end
