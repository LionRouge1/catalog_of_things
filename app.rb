require './actions/movie_actions'
require './actions/game_actions'
require './actions/book_actions'
require './actions/music_album_actions'
require './json/json_manipulation'

class App
  def initialize
    @movie_action = MovieActions.new
    @book_action = BookActions.new
    @game_action = GameActions.new
    @music_album_action = MusicAlbumActions.new
    @savejson = Manipulation.new
  end

  def redirection(option)
    case option
    when 1
      @book_action.list_all_books
    when 2
      @music_album_action.list_all_music_albums
    when 3
      @movie_action.list_all_movies
    when 4
      @game_action.list_all_games
    when 5
      @movie_action.list_all_genres
    when 6
      @movie_action.list_all_labels
    when 7
      @movie_action.list_all_authors
    when 8
      @movie_action.list_all_sources
    when 9
      @book_action.add_book
    when 10
      @music_album_action.add_music_album
    when 11
      @movie_action.add_movie
    when 12
      @game_action.add_game
    when 13
      @savejson.save_data(@book_action.books, 'books.json')
      @savejson.save_data(@music_album_action.music_albums, 'music_albums.json')
      @savejson.save_data(@movie_action.movies, 'movies.json')
      @savejson.save_data(@game_action.games, 'games.json')
      @savejson.save_data(@movie_action.GENRES, 'genres.json')
      @savejson.save_data(@movie_action.LABELS, 'labels.json')
      @savejson.save_data(@movie_action.AUTHORS, 'authors.json')
      @savejson.save_data(@movie_action.SOURCES, 'sources.json')
    else
      p 'Invalid input'
    end
  end
end
