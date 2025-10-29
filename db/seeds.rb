# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Limpando dados"
Script.destroy_all
Checklist.destroy_all
User.destroy_all

puts "Criando usuários, roteiros e checklists"
main_user = User.create!(
  name: "John Doe",
  email: "johndoe@example.com",
  password: "123456",
  password_confirmation: "123456",
  confirmed_at: Time.current
)
second_user = User.create!(
  name: "John Smith",
  email: "johnsmith@example.com",
  password: "123456",
  password_confirmation: "123456",
  confirmed_at: Time.current
)

Script.create!(
  title: "Viagem para " + Faker::Address::city,
  user: main_user
)

second_script = Script.create!(
  title: "Viagem para " + Faker::Address::street_name,
  user: second_user
)

Participant.create!(
  user: main_user,
  script: second_script
)

Checklist.create!(
  title: Faker::Lorem.sentence,
  user: main_user
)

puts "Usuários criados!"

User.all.each do |user|
  puts user.name
  puts user.email
  puts '123456'
end