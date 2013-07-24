FactoryGirl.define do
    # Define a basic devise user.
    factory :user do
        email "example@example.com"
        password "examplepass"
        password_confirmation "examplepass"
        confirmed_at DateTime.now
        phone 9523707281
        card_number 777777
    end
end
