FactoryGirl.define do
  factory :user_comment do |c|
    c.message "Varias ideias, varias cabecas"
    c.association :comment_sender, :factory => :user
    c.association :comment_receiver, :factory => :user
  end
end