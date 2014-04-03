# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :booking do
    id 1
    machine_id 1
    user_id 1
    start '2014-01-24 08:07:38'
    'end' '2014-01-24 08:07:38'
  end
end
