# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

puts "Limpando dados"
# Ordem correta para evitar erros de foreign key
if defined?(Review)
  Review.destroy_all
end

if defined?(Destination)
  Destination.destroy_all
end

if defined?(Hotel)
  Hotel.destroy_all
end

if defined?(Tour)
  Tour.destroy_all
end

# Limpar dados de scripts e checklists
ScriptSpend.destroy_all if defined?(ScriptSpend)
ScriptComment.destroy_all if defined?(ScriptComment)
ScriptItem.destroy_all if defined?(ScriptItem)
ScriptParticipant.destroy_all if defined?(ScriptParticipant)
ChecklistItem.destroy_all if defined?(ChecklistItem)
ChecklistParticipant.destroy_all if defined?(ChecklistParticipant)

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

# Criar usuários adicionais para reviews
third_user = User.create!(
  name: "Maria Silva",
  email: "maria@example.com",
  password: "123456",
  password_confirmation: "123456",
  confirmed_at: Time.current
)

fourth_user = User.create!(
  name: "Carlos Santos",
  email: "carlos@example.com",
  password: "123456",
  password_confirmation: "123456",
  confirmed_at: Time.current
)

Script.create!(
  title: "Viagem para " + Faker::Address.city,
  user: main_user
)

second_script = Script.create!(
  title: "Viagem para " + Faker::Address.street_name,
  user: second_user
)

ScriptParticipant.create!(
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

# Criar dados de exemplo para Reviews (apenas se os models existirem)
if defined?(Destination) && defined?(Hotel) && defined?(Tour) && defined?(Review)
  puts "\nCriando destinos, hotéis e tours..."
  
  users = [main_user, second_user, third_user, fourth_user]
  
  # Criar Destinos
  destinations = 3.times.map do
    Destination.create!(
      name: Faker::Address.city,
      description: Faker::Lorem.paragraph(sentence_count: 3)
    )
  end
  
  # Criar Hotéis
  hotels = 3.times.map do
    Hotel.create!(
      name: "Hotel #{Faker::Company.name}",
      address: Faker::Address.full_address
    )
  end
  
  # Criar Tours
  tours = 3.times.map do
    Tour.create!(
      title: Faker::Lorem.sentence(word_count: 4),
      description: Faker::Lorem.paragraph(sentence_count: 3)
    )
  end
  
  puts "Criando avaliações..."
  
  # Criar avaliações para cada tipo de reviewable
  [destinations, hotels, tours].flatten.each do |reviewable|
    rand(2..4).times do
      user = users.sample
      begin
        Review.create!(
          reviewable: reviewable,
          user: user,
          rating: rand(1..5),
          title: Faker::Lorem.sentence(word_count: 3),
          comment: Faker::Lorem.paragraph(sentence_count: rand(2..4))
        )
      rescue ActiveRecord::RecordInvalid => e
        # Skip se usuário já avaliou este item
        puts "  Pulando avaliação duplicada: #{e.message}"
      end
    end
  end
  
  puts "\nResumo dos dados criados:"
  puts "Destinos: #{Destination.count}"
  puts "Hotéis: #{Hotel.count}"
  puts "Tours: #{Tour.count}"
  puts "Avaliações: #{Review.count}"
  
  puts "\nExemplo de estatísticas:"
  if destinations.first.reviews.any?
    dest = destinations.first
    puts "#{dest.name}: #{dest.reviews_count} avaliações, média: #{dest.average_rating}"
  end
end

puts "\nSeeds concluídos!"