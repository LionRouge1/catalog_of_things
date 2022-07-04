require './catalog_classes/book'
require './json/json_manipulation'
require './modules/source_module'
require './modules/genre_module'
require './modules/label_module'
require './modules/author_module'

class BookActions
  attr_accessor :books

  def initialize
    readjson = Manipulation.new
    @books = readjson.read_data('books.json') || []
  end

  include SourceModule
  include GenreModule
  include AuthorModule
  include LabelModule
  
  def add_book
    add_source
    add_genre
    add_label
    add_author

    print 'Publish date in format [d/mm/YYYY]: '
    publish_date = gets.chomp
    print 'Publisher: '
    publisher = gets.chomp
    print 'Cover state: '
    cover_state = gets.chomp
    book = Book.new(publish_date, publisher, cover_state)
    @source.add_item(book)
    @genre.add_item(book)
    @label.add_item(book)
    @author.add_item(book)
    book_obj = { id: book.id, author: [book.author.first_name, book.author.last_name], 
                  source: book.source.name, label: [book.label.title, book.label.color], 
                  genre: book.genre.name, publish_date: book.publish_date, publisher: book.publisher, 
                  cover_state: book.cover_state }
    @books << book_obj unless @books.include?(book_obj)
    puts 'book successfully created'
  end

  def list_all_books
    @books.map do |book|
      puts "ID: #{book[:id]}
        Author full name: #{book[:author][0]} #{book[:author][1]}
        Source: #{book[:source]}
        Label title: #{book[:label][0]} Color: #{book[:label][1]}
        Publish date: #{book[:publish_date]}
        Publisher: #{book[:publisher]}
        Cover state: #{book[:cover_state]}"
      
      puts ''
    end
  end
end
