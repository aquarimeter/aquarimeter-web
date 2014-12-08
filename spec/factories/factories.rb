FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    sequence(:email) { |n| Faker::Internet.free_email("User#{n}") }
    password "please1234"
    trait :admin do
      role 'admin'
    end
  end

  factory :aquarium do |a|
    a.sequence(:name) { |n| "#{Faker::Name.name} #{Kernel.rand(n..1000)}" }
    a.ideal_temp_low Kernel.rand(68.3..72.3)
    a.ideal_temp_high Kernel.rand(73.0..75.99)
    a.association :user, :factory => :user
  end

  factory :sensor_reading do
    ph Kernel.rand(0.0..14.0)
    temperature Kernel.rand(75..90)
    association :aquarium, :factory => :aquarium
  end
end


