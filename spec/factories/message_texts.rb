# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message_text do
    content "MyText"
    message_type 1
  end
end
