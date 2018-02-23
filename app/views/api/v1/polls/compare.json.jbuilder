json.array! @all_combination do |combination|
  json.array! combination do |proposition|
    json.extract! proposition, :id, :name, :color
  end
end
