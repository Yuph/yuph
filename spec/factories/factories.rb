FactoryGirl.define do
  factory :idea do
    name "art in vinil"
    image_file_name "yuph.png"
    mini_description "arte no vinil"
    description "arte no vinil"
  end
  factory :message do
    body "Novidades ? Vamos implementar aquela idea?"
    title "Novidades ?"
  end
  factory :user_comment do
    message "Varias ideias, varias cabecas"
  end
  factory :idea_comment do
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

  factory :idea_admin do
    association :idea
    association :user
  end

  factory :follow do
  end
end
