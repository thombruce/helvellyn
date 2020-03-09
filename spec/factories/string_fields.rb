FactoryBot.define do
  factory :string_field do
    min_length { 1 }
    max_length { 1 }
    default_value { "MyString" }
  end
end
