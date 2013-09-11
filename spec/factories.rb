FactoryGirl.define do
  factory :user do |f|
    f.sequence(:nick) {|n| "victor-antoniazzi-simple-#{n}" }
    f.sequence(:email) {|n| "person-simple#{n}@example.com" }
    f.password "pass12345"
  end
  factory :full_user, :class => User do |f|
    f.sequence(:nick) {|n| "victor-antoniazzi-complex-#{n}" }
    f.sequence(:email) {|n| "person-complex#{n}@example.com" }
    f.password "pass12345"
    f.image_file_name "test.jpg"
    f.about "hi, i am a softaew developer"
    f.local "Pelotas - RS"
    f.website "www.victorantoniazzi.com.br"
    f.facebook "fb.com/oi?"
    f.twitter "@antoniazzii"
  end
  factory :idea do
    name "art in vinil"
    image_file_name "yuph.png"
    mini_description "arte no vinil"
    description "arte no vinil"
  end
  factory :message do
    title "Como estás ?"
    body "Novidades ? Vamos implementar aquela idea?"
  end
  factory :user_comment do
    title "O cara"
    message "Várias idéias, várias cabeças"
  end
  factory :idea_comment do
    title "Muito Bacana!!"
    message "Adorei a iniciativa."
  end
  factory :forum do
    password ""
  end
  factory :post do
    title "Post title"
    message "Post Message"
  end
  factory :post_comment do
    title "Post comment title"
    message "Post comment Message"
  end
  factory :category do
    title "Sobre valores"
    description "tire as suas dúvidas sobre valores"
  end
  factory :idea_admin do
  end
  factory :follow do
  end
end
