require "./catalog_classes/label"
require "./json/json_manipulation"

module LabelModule
  readjson = Manipulation.new
  LABELS = readjson.read_data('labels.json') || []

  def labels_from_list
    print 'Select by ID: '
    option_id = gets.to_i
    opt_id = LABELS.select { |i| i[:id] == option_id }.first
    if opt_id
      @label = Label.new(opt_id[:title], opt_id[:color], opt_id[:id])
    else
      p 'Invalid ID'
      add_label
    end
  end

  def new_label
    print 'Label title: '
    title = gets.chomp
    print 'Label color: '
    color = gets.chomp
    @label = Label.new(title, color)
    label_obj = { id: @label.id, title: @label.title, color: @label.color }
    LABELS << label_obj unless LABELS.include?(label_obj)
  end

  def add_label
    if LABELS.empty?
      option = 'N'
    else
      print 'Do you want select a label from existing list? [Y/N]: '
      option = gets.chomp
    end

    case option
    when 'Y', 'y', 'yes', 'YES'
      list_all_labels
      labels_from_list
    when 'N', 'n', 'no', 'NO'
      new_label
    else
      p 'Invalid input'
      add_label
    end
  end

  def list_all_labels
    LABELS.map { |label| puts "ID: #{label[:id]} Title: #{label[:title]} Color: #{label[:color]}" }
  end
end