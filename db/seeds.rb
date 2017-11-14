Faker::Name.name

puts 'Cleaning database...'
Shower.destroy_all
User.destroy_all
Reservation.destroy_all
url = "https://picsum.photos/1920/1080/?random"

puts 'Creating 5 fake users...'
5.times do
  user = User.new(
    name:    Faker::Name.name,
    address: "#{Faker::Address.street_address}, #{Faker::Address.city}",
    surname: Faker::Name.last_name,
    email: Faker::Internet.email,
    host: false,
    password: "topsecret"
    )
  user.avatar_url = url
  user.save!
end

puts 'Finished!'

addresses = [
  'avenue victor jacobs 78, 1040 bruxelles',
  'avenue montjoie 118, 1180 Bruxelles',
  'grote hertstraat 5, 1653, Dworp'
]

puts 'Creating 15 fake showers...'
15.times do
  shower = Shower.new(
    title:    Faker::Space.planet,
    address: addresses.sample,
    user: User.all.sample,
    price: Faker::Number.decimal(2),
    description: Faker::Coffee.blend_name
    )
  shower.save!
  shower.picture_urls = [url]
  24.times do |x|
    available = Availibility.new(hour: x)
    if (x >= 8) && (x <= 20)
      available.available = true
    else
      available.available = false
    end
    available.shower = shower
    available.save!
  end

end
puts 'Finished!'

# create_table "participants", force: :cascade do |t|
#     t.bigint "poll_id"
#     t.bigint "user_id"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.index ["poll_id"], name: "index_participants_on_poll_id"
#     t.index ["user_id"], name: "index_participants_on_user_id"
#   end

#   create_table "polls", force: :cascade do |t|
#     t.string "title"
#     t.text "description"
#     t.string "photo"
#     t.boolean "status"
#     t.bigint "user_id"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.index ["user_id"], name: "index_polls_on_user_id"
#   end

#   create_table "profiles", force: :cascade do |t|
#     t.string "name"
#     t.string "surname"
#     t.string "photo"
#     t.bigint "user_id"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.index ["user_id"], name: "index_profiles_on_user_id"
#   end

#   create_table "propositions", force: :cascade do |t|
#     t.string "name"
#     t.integer "score"
#     t.string "photo"
#     t.string "hashtag"
#     t.text "description"
#     t.bigint "poll_id"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.index ["poll_id"], name: "index_propositions_on_poll_id"
#   end

#   create_table "users", force: :cascade do |t|
#     t.string "email", default: "", null: false
#     t.string "encrypted_password", default: "", null: false
#     t.string "reset_password_token"
#     t.datetime "reset_password_sent_at"
#     t.datetime "remember_created_at"
#     t.integer "sign_in_count", default: 0, null: false
#     t.datetime "current_sign_in_at"
#     t.datetime "last_sign_in_at"
#     t.inet "current_sign_in_ip"
#     t.inet "last_sign_in_ip"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.index ["email"], name: "index_users_on_email", unique: true
#     t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
#   end

#   create_table "votes", force: :cascade do |t|
#     t.bigint "poll_id"
#     t.bigint "user_id"
#     t.bigint "accepted_proposition_id"
#     t.bigint "rejected_proposition_id"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.index ["accepted_proposition_id"], name: "index_votes_on_accepted_proposition_id"
#     t.index ["poll_id"], name: "index_votes_on_poll_id"
#     t.index ["rejected_proposition_id"], name: "index_votes_on_rejected_proposition_id"
#     t.index ["user_id"], name: "index_votes_on_user_id"
#   end

#   add_foreign_key "participants", "polls"
#   add_foreign_key "participants", "users"
#   add_foreign_key "polls", "users"
#   add_foreign_key "profiles", "users"
#   add_foreign_key "propositions", "polls"
#   add_foreign_key "votes", "polls"
#   add_foreign_key "votes", "users"
# end
