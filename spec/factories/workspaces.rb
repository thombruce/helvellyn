FactoryBot.define do
  factory :workspace do
    association :created_by, factory: :user
    title { "MyString" }
  end
end
