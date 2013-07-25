FactoryGirl.define do
    # Define a basic devise user.
    factory :user do
        email 79523707281
        password "examplepass"
        password_confirmation "examplepass"
        confirmed_at DateTime.now
        card_number 777777
        account
    end
end
