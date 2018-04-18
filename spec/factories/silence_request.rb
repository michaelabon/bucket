FactoryBot.define do
  factory :silence_request do
    requester 'User Name'
    silence_until { Time.zone.now + 30.minutes }

    trait :expired do
      silence_until { 3.days.ago }
    end
  end
end
