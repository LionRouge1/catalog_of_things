require './catalog_classes/movie'
require './catalog_classes/item'
require './json/json_manipulation'
require './modules/source_module'
require './modules/genre_module'
require './modules/label_module'
require './modules/author_module'

class MovieActions
  attr_accessor :movies, :sources

  def initialize
    readjson = Manipulation.new
    @movies = readjson.read_data('movies.json') || []
  end

  include SourceModule
  include GenreModule
  include AuthorModule
  include LabelModule
  
  def add_movie
    add_source
    add_genre
    add_label
    add_author

    print 'Publish date in format d/mm/YYYY: '
    publish_date = gets.chomp
    print 'Is it silent? [Y/N]: '
    silent = gets
    movie = Movie.new(publish_date, silent)
    @source.add_item(movie)
    @genre.add_item(movie)
    @label.add_item(movie)
    @author.add_item(movie)
    movie_obj = { id: movie.id, author: [movie.author.first_name, movie.author.last_name], 
                  source: movie.source.name, label: [movie.label.title, movie.label.color], 
                  genre: movie.genre.name, publish_date: movie.publish_date }
    @movies << movie_obj unless @movies.include?(movie_obj)
    puts 'Movie successfully created'
  end

  def list_all_movies
    @movies.map do |movie|
      puts "ID: #{movie[:id]}
        Author full name: #{movie[:author][0]} #{movie[:author][1]}
        Source: #{movie[:source]}
        Label title: #{movie[:label][0]} #{movie[:label][1]}
        Publish date: #{movie[:publish_date]}"
    end
  end
end
