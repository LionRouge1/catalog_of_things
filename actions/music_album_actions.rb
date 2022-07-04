require './catalog_classes/music_album'
require './json/json_manipulation'
require './modules/source_module'
require './modules/genre_module'
require './modules/label_module'
require './modules/author_module'

class MusicAlbumActions
  attr_accessor :music_albums

  def initialize
    readjson = Manipulation.new
    @music_albums = readjson.read_data('music_albums.json') || []
  end

  include SourceModule
  include GenreModule
  include AuthorModule
  include LabelModule
  
  def add_music_album
    add_source
    add_genre
    add_label
    add_author

    print 'Publish date in format [d/mm/YYYY]: '
    publish_date = gets.chomp
    print 'Is it on spotify [Y/N]: '
    input = gets.chomp
    on_spotify = ['yes', 'y', 'Y', 'YES'].include?(input) ? true : false
    music_album = MusicAlbum.new(publish_date, on_spotify)
    @source.add_item(music_album)
    @genre.add_item(music_album)
    @label.add_item(music_album)
    @author.add_item(music_album)
    music_album_obj = { id: music_album.id, author: [music_album.author.first_name, music_album.author.last_name], 
                  source: music_album.source.name, label: [music_album.label.title, music_album.label.color], 
                  genre: music_album.genre.name, publish_date: music_album.publish_date, on_spotify: music_album.on_spotify}
    @music_albums << music_album_obj unless @music_albums.include?(music_album_obj)
    puts 'music_album successfully created'
  end

  def list_all_music_albums
    @music_albums.map do |music_album|
      puts "ID: #{music_album[:id]}
        Author full name: #{music_album[:author][0]} #{music_album[:author][1]}
        Source: #{music_album[:source]}
        Label title: #{music_album[:label][0]} Color: #{music_album[:label][1]}
        Publish date: #{music_album[:publish_date]}
        It is #{music_album[:on_spotify] ? '' : 'not '}on sporty"
      puts ''
    end
  end
end
