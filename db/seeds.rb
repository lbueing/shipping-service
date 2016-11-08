# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users = [
  {
    name: "wallace"
    zip: "61455"
  }
  {
    name: "gertrude"
    zip: "98029"
  }
  {
    name: "maevis"
    zip: "62005"
  }
]

users.each do |user|
  User.create(user)
end
