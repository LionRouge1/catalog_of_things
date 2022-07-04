require "./catalog_classes/genre"
require "./json/json_manipulation"

module GenreModule
  readjson = Manipulation.new
  GENRES = readjson.read_data('genres.json') || []

  def genres_from_list
    print 'Select by ID: '
    option_id = gets.to_i
    opt_id = GENRES.select { |i| i[:id] == option_id }.first
    if opt_id
      @genre = Genre.new(opt_id[:name], opt_id[:id])
    else
      p 'Invalid ID'
      add_genre
    end
  end

  def new_genre
    print 'Enter genre: '
    name = gets.chomp
    @genre = Genre.new(name)
    genre_obj = { id: @genre.id, name: @genre.name }
    GENRES << genre_obj unless GENRES.include?(genre_obj)
  end

  def add_genre
    if GENRES.empty?
      option = 'N'
    else
      print 'Do you want select a genre from existing list? [Y/N]: '
      option = gets.chomp
    end

    case option
    when 'Y', 'y', 'yes', 'YES'
      list_all_genres
      genres_from_list
    when 'N', 'n', 'no', 'NO'
      new_genre
    else
      p 'Invalid input'
      add_genre
    end
  end

  def list_all_genres
    GENRES.map { |genre| puts "ID: #{genre[:id]} Name: #{genre[:name]}" }
  end
end