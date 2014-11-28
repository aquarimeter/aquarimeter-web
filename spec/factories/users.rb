FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    first_name "Test"
    last_name "User"
    email "test@example.com"
    password "please123"

    trait :admin do
      role 'admin'
    end

  end
end
