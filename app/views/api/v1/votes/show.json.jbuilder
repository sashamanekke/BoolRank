json.extract! @poll, :id, :title, :description
json.participants @poll.participants do |participant|
  json.extract! participant, :id
end
json.propositions @poll.propositions do |proposition|
  json.extract! proposition, :id, :name, :score, :color
end
json.votes @poll.votes do |vote|
  json.extract! vote, :id, :accepted_proposition_id, :rejected_proposition_id
end
