FactoryGirl.define do
  factory :user do
    nick "victor-antoniazzi"
    email  "vgsantoniazzi@gmail.com"
    password "pass12345"
  end
  factory :full_user, :class => User do
    nick "victor-antoniazzi"
    email  "vgsantoniazzi@gmail.com"
    password "pass12345"
    image "test"
    about "hi, i am a softaew developer"
    local "Pelotas - RS"
    website "www.victorantoniazzi.com.br"
    facebook "fb.com/oi?"
    twitter "@antoniazzii"
  end
end
