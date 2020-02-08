FactoryBot.define do
  factory :post do
    user
    content { "Generic post text." }
  end
end
