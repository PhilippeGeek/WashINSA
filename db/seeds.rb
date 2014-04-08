# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

if Rails.env == 'development' # Add test data for dev
  laundrette=Laundrette.create! name: 'Laverie du B', opened:true,description:'',notes:''
  5.times do |n|
    Machine.create! name: "Machine #{n}", laundrette_id:laundrette.id
  end
  Machine.create! name: 'Sèche linge'
  Building.create! name:'Batiment A', laundrette_id:laundrette.id
  Building.create! name:'Batiment B', laundrette_id:laundrette.id
end