require "./catalog_classes/source"
require "./json/json_manipulation"

module SourceModule
  readjson = Manipulation.new
  SOURCES = readjson.read_data('sources.json') || []

  def sources_from_list
    print 'Select by ID: '
    option_id = gets.to_i
    opt_id = SOURCES.select { |i| i[:id] == option_id }.first
    if opt_id
      @source = Source.new(opt_id[:name], opt_id[:id])
    else
      p 'Invalid ID'
      add_source
    end
  end

  def new_source
    print 'Enter source: '
    input = gets.chomp
    @source = Source.new(input)
    source_obj = { id: @source.id, name: @source.name }
    SOURCES << source_obj unless SOURCES.include?(source_obj)
  end

  def add_source
    if SOURCES.empty?
      option = 'N'
    else
      print 'Do you want select a source from existing list? [Y/N]: '
      option = gets.chomp
    end

    case option
    when 'Y', 'y', 'yes', 'YES'
      list_all_sources
      sources_from_list
    when 'N', 'n', 'no', 'NO'
      new_source
    else
      p 'Invalid input'
      add_source
    end
  end

  def list_all_sources
    SOURCES.map { |source| puts "ID: #{source[:id]} Name: #{source[:name]}" }
  end
end