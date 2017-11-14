# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Cleaning database...'
User.destroy_all
Profile.destroy_all
Poll.destroy_all
Proposition.destroy_all
Vote.destroy_all
Participant.destroy_all

# url_image = "https://picsum.photos/1920/1080/?random"
# avatar = "put here link for random...? if we don't use the UiFaces gem"
# url_image_fruit = "https://unsplash.com/search/photos/fruits"

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
  profile.photo = UiFaces.face
  profile.user = User.all[x]
  profile.save!
end

puts 'Creating 5 fake polls...'
5.times do |x|
  poll = Poll.new(
    user: User.all[x],
    title: Faker::Space.planet,
    description: "This poll is about ... (add what you want)",
    photo: "https://picsum.photos/1920/1080/?random",
    status: true,
    )
  poll.save!
  #shower.picture_urls = [url]
  puts 'Creating 5 fake proposition per poll...'
  5.times do
    proposition = Proposition.new(
      name: Faker::Food.ingredient,
      score: rand(1..10),
      photo: "https://source.unsplash.com/1600x900/?fruits",
      hashtag: "#",
      description: "Add some nice description about this proposition"
      )
    proposition.poll = poll
    proposition.save!
  end
  puts "Creating 10 fake proposition for poll #{x}"
  10.times do |y|
    vote = Vote.new()
    vote.poll = poll
    vote.user = User.all.sample
    vote.accepted_proposition = poll.propositions.sample
    vote.rejected_proposition = poll.propositions.sample
    vote.save!
  end
end
puts 'Finished!'

