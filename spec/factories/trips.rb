# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip do
    user nil
    trip_date "2013-07-25 14:43:29"
    duration 1
    price "9.99"
    bonus_point 1
  end
end
