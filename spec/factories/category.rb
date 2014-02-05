FactoryGirl.define do

  factory :category do
    title "Valores"
    description "tire as suas duvidas sobre valores"
  end

  factory :off_topic_category, :class => Category do
    title "Off-Topic"
    description { |c| c.title }
  end

  factory :general_category, :class => Category do
    title "Geral"
    description { |c| c.title }
  end

  factory :suggestion_category, :class => Category do
    title "Sugestões"
    description { |c| c.title }
  end

  factory :brainstorm_category, :class => Category do
    title "Brainstorm"
    description { |c| c.title }
  end

end