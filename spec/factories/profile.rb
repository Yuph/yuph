FactoryGirl.define do
  factory :profile do |p|
    p.sequence(:nick) {|n| "victor-antoniazzi-complex-#{n}" }
    p.sequence(:email) {|n| "person-complex#{n}@example.com" }

    factory :full_profile do |p|
      p.image_file_name "test.jpg"
      p.about "hi, i am a softaew developer"
      p.local "Pelotas - RS"
      p.website "www.victorantoniazzi.com.br"
      p.facebook "fb.com/oi?"
      p.twitter "@antoniazzii"
    end
  end
end