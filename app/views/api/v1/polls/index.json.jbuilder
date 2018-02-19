json.array! @polls do |poll|
  json.extract! poll, :id, :title, :description, :status
end
