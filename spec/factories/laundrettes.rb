# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :laundrette do
    name "MyString"
    notes "MyText"
    description "MyText"
    opened false
  end
end
