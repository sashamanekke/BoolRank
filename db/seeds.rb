#
puts 'Cleaning database...'
User.destroy_all
Profile.destroy_all
Poll.destroy_all
Proposition.destroy_all
Vote.destroy_all
Participant.destroy_all

puts 'Creating 5 fake users...'
5.times do
  user = User.new(
    email: Faker::Internet.email,
    password: "topsecret"
    )
  user.save!
end

puts 'Creating 5 fake profiles...'
5.times do |x|
  profile = Profile.new(
    name:    Faker::Name.name,
    surname: Faker::Name.last_name
    )
  # profile.photo = UiFaces.face
  profile.user = User.all[x]
  profile.save!
end

puts 'Creating 5 fake polls...'
5.times do |x|
  poll = Poll.new(
    user: User.all[x],
    title: Faker::Space.planet,
    description: "This poll is about ... (add what you want)",
    # photo: "https://picsum.photos/1920/1080/?random",
    status: true,
    )
  poll.save!
  #shower.picture_urls = [url]
  puts 'Creating 6 fake proposition per poll...'
  colors = ["#FF0000","#FFFF00","#00FF00","#00FFFF"," #0000FF","#FF00FF"]
  photos_url = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9-yKOwhwjlGlHCeWZllhaw3GPukr2q95AsYSmBfnboUXLeQ_6iQ",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRZzAExN62lD9lJQ5TpjTP6vaP8RUg3W1rseem-59KqugvkMnS",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEQLDAtmhlQXVME_97PFOZ6EEPOg_xtgzsZ5CR1N4idg-fqho7sg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpwYc8lRGsLHVR0VL193utzZJhYvsTy-lPMNgsHiuEQsVcXFXT",
  ]
  4.times do |i|
    proposition = Proposition.new(
      name: Faker::Food.ingredient,
      score: 0,
      # photo: "https://source.unsplash.com/1600x900/?random",
      hashtag: "#",
      description: "Add some nice description about this proposition",
      color: colors.sample,
      )
    proposition.photo_url = photos_url[i-1]
    proposition.poll = poll
    proposition.save!
  end
  2.times do |i|
    proposition = Proposition.new(
      name: Faker::Food.ingredient,
      score: 0,
      # photo: "https://source.unsplash.com/1600x900/?random",
      hashtag: "#",
      description: "Add some nice description about this proposition",
      color: colors.sample,
      )
    proposition.poll = poll
    proposition.save!
  end


  # puts "Creating 10 fake votes for poll #{x}"
  # 10.times do |y|
  #   vote = Vote.new()
  #   vote.poll = poll
  #   vote.user = User.all.sample
  #   vote.accepted_proposition = poll.propositions.sample
  #   vote.rejected_proposition = poll.propositions.sample
  #   vote.save!
  # end

    puts "Creating 10 fake participants for poll #{x}"
  10.times do |y|
    participant = Participant.new()
    participant.poll = poll
    participant.user = User.all.sample
    participant.save!
  end
end
puts 'Finished!'

