FactoryGirl.define do
  factory :user do
    confirmed_at          Time.now
    sequence(:first_name) { |n| "Tester #{n}"}
    sequence(:last_name)  { |n| "Last #{n}"}
    sequence(:email)      { |n| "tester#{n}@acme.com"}
    password              "testing"
    sequence(:address)    { |n| "12{n} Vignetto St."}  
    city                  "Calistoga"
    state                 "CA"
    zipcode              "94515"
    phone                "916-123-1234"

    trait :admin do
      role 'admin'
    end
    trait :host do
      role 'host'
    end
    trait :participant do
      role 'participant'
    end
  end
end
