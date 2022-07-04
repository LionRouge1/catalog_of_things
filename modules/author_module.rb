require "./catalog_classes/author"
require "./json/json_manipulation"

module AuthorModule
  readjson = Manipulation.new
  AUTHORS = readjson.read_data("authors.json") || []

  def authors_from_list
    print "Select by ID: "
    option_id = gets.to_i
    opt_id = AUTHORS.select { |i| i[:id] == option_id }.first
    if opt_id
      @author = Author.new(opt_id[:first_name], opt_id[:last_name], opt_id[:id])
    else
      p "Invalid ID"
      add_author
    end
  end

  def new_author
    print "Author first name: "
    first_name = gets.chomp
    print "Author last name: "
    last_name = gets.chomp
    @author = Author.new(first_name, last_name)
    author_obj = { id: @author.id, first_name: @author.first_name, last_name: @author.last_name }
    AUTHORS << author_obj unless AUTHORS.include?(author_obj)
  end

  def add_author
    if AUTHORS.empty?
      option = "N"
    else
      print "Do you want select an author from existing list? [Y/N]: "
      option = gets.chomp
    end

    case option
    when "Y", "y", "yes", "YES"
      list_all_authors
      authors_from_list
    when "N", "n", "no", "NO"
      new_author
    else
      p "Invalid input"
      add_author
    end
  end

  def list_all_authors
    AUTHORS.map { |author| puts "ID: #{author[:id]} First name: #{author[:first_name]} Last name: #{author[:last_name]}" }
  end
end
