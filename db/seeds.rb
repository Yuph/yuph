# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(email: "estagiario@yuph.net", password: "53245324")
user.profile = Profile.create nick: "estagiario"
puts " * Create user #{user.nick}"

idea = Idea.create(name: "Yuph", mini_description: "Um ambiente em que qualquer ideia pode se tornar algo incrível.", description: "Siga-nos", image_file_name: "/assets/big-logo.png")
puts " * Create idea #{idea.name}"

idea.users << user
idea.save!
Forum.create!(idea: idea)
