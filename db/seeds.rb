# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ps = { name: 'User One', email: 'one@test.com', 
		password: '123123', password_confirmation: '123123' }
users = []
users << User.create(ps)
puts "user #{users.last.name} created"

ps.merge!(name: 'User Two', email: 'two@test.com')
users << User.create(ps)
puts "user #{users.last.name} created"

Message.create([
  {body: 'hello one', user_id: users.first.id},
  {body: 'hello one one', user_id: users.first.id},
  {body: 'hi', user_id: users.second.id},
])

puts '3 messages created'