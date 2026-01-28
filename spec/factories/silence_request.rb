FactoryBot.define do
  factory :silence_request do
    requester { 'User Name' }
    silence_until { 30.minutes.from_now }

    trait :expired do
      silence_until { 3.days.ago }
    end
  end
end
