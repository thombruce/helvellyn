FactoryBot.define do
  factory :content_type_field do
    content_type { nil }
    name { "MyString" }
    actable_id { 1 }
    actable_type { "MyString" }
  end
end
