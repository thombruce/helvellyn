FactoryBot.define do
  factory :role do
    name { "new_user" }

    # create(:role)
    for_workspace

    # create(:role, :for_workspace)
    trait :for_workspace do
      association :resource, factory: :workspace
    end

    # create(:role, :for_entity)
    trait :for_entity do
      association :resource, factory: :entity
    end

    # create(:role_with_users)
    factory :role_with_users do
      transient do
        users_count { 5 }
      end

      after(:create) do |role, evaluator|
        create_list(:user, evaluator.users_count, roles: [role])
      end
    end
  end
end
