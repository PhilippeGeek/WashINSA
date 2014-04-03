# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :machine do
    name "MyString"
    blocked false
    building_id 1
  end
end
