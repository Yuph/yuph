FactoryGirl.define do
  factory :user do |u|
    u.association :profile
    u.password "12345678"
    u.password_confirmation { |u2| u2.password }
    u.sequence(:email) {|n| "person-complex#{n}@example.com" }

    factory :full_user do |u|
      u.association :profile, :factory => :full_profile
    end
  end
end