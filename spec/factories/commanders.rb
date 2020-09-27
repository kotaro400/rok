FactoryBot.define do
  factory :commander do
    sequence(:name) {|n| "ライキン#{n}世"}
    rarity {"レジェンド"}

    trait :epic do
      rarity {"エピック"}
    end
  end
end
