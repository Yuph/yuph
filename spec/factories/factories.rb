FactoryGirl.define do
  factory :message do
    body "Novidades ? Vamos implementar aquela idea?"
    title "Novidades ?"
  end
  factory :idea_comment do
    message "Adorei a iniciativa."
  end
  factory :forum do
    password ""
    association :idea
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
