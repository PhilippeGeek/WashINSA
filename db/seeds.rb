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
  puts 'Fake data'
  # Add building1 to building5 as demo building
  for i in 1..5 do
    Building.create(:name=>'building'+i.to_s) if Building.find_by_name('building'+i.to_s).nil?
  end
  buildings_for_machines = (1..5).to_a.shuffle![0..7]

  # Add machine1 to machine8 as demo machine
  for i in 1..8 do
    Machine.create!(
        :name=>'machine'+i.to_s,
        :blocked=>false,
        :building=> Building.find_by_name('building'+buildings_for_machines[i].to_s)
    ) if Machine.find_by_name('machine'+i.to_s).nil?
  end
end