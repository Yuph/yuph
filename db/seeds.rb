# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(nick: "victor-antoniazzi", email: "vgsantoniazzi@gmail.com", password: "53245324")
idea = Idea.create(name: "Yuph", mini_description: "Brainstorming de ideias", description: "Junte-se a nós", image_file_name: "/assets/yuph.png")
idea.users << user
idea.save!
Forum.create!(idea: idea)
