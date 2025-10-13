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
  name: "Usuário teste",
  email: "testuser@example.com",
  password: "123456",
  password_confirmation: "123456",
)

Script.create!(
  title: "Viagem para " + Faker::Address::city,
  user: main_user
)

Checklist.create!(
  title: Faker::Lorem.sentence,
  user: main_user
)

puts "Usuário criado: {name=Usuário teste, email=testuser@example.com, password=123456}"