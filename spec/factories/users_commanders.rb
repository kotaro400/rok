FactoryBot.define do
  factory :users_commander do
    skill1 {1}
    skill2 {1}
    skill3 {1}
    skill4 {1}
    association :user
    association :commander

    trait :full do
      skill1 {5}
      skill2 {5}
      skill3 {5}
      skill4 {5}
    end

    trait :epic do
      association :commander, :epic
    end
  end
end
