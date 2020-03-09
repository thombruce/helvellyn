FactoryBot.define do
  factory :text_field do
    wysiwyg { false }
    min_length { 1 }
    max_length { 1 }
    default_value { "MyText" }
  end
end
