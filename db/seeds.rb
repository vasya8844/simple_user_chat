# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ps = { name: 'admin', email: 'admin@test.com', 
	password: '123123', password_confirmation: '123123'}
AdminUser.create(ps)
puts "#{AdminUser.last.name} created"

users = []
ps.merge!(name: 'User Two', email: 'two@test.com')
users << User.create(ps)
puts "user #{users.last.name} created"

ps.merge!(name: 'User Three', email: 'three@test.com')
users << User.create(ps)
puts "user #{users.last.name} created"

ps.merge!(name: 'User Blocked', email: 'blocked@test.com', is_blocked: true)
users << User.create(ps)
puts "user #{users.last.name} created"

