# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name(role)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.confirm!
user.add_role :admin

if Rails.env == 'development' # Add test data for dev
  puts 'Fake data'
  # Add building1 to building5 as demo building
  for i in 1..5 do
    Building.create(:name=>'building'+i.to_s) if Building.find_by_name('building'+i.to_s).nil?
  end

  buildings_for_users = (1..5).to_a.shuffle![0..8]
  buildings_for_machines = (1..5).to_a.shuffle![0..7]

  # Add user1 to user9 as demo user
  for i in 1..9 do
    user=User.new(
        :name=>'user'+i.to_s,
        :email => 'user'+i.to_s+'@bde.insa-lyon.fr',
        :password => 'password',
        :password_confirmation=>'password',
        :building => Building.find_by_name('building'+buildings_for_users[i].to_s)) if User.find_by_name('user'+i.to_s).nil?
    user.save!
    user.confirm!
    user.add_role :user
  end

  # Add machine1 to machine8 as demo machine
  for i in 1..8 do
    Machine.create!(
        :name=>'machine'+i.to_s,
        :blocked=>false,
        :building=> Building.find_by_name('building'+buildings_for_machines[i].to_s)
    ) if Machine.find_by_name('machine'+i.to_s).nil?
  end
end