FactoryBot.define do
  factory :unit do
    sequence(:main_commander_id) {|n| n % 30 + 1 }
    sequence(:sub_commander_id) {|n| n % 30 + 2 }

    trait :unit_1 do
      main_commander_id {1}
      sub_commander_id {2}
    end

    trait :unit_2 do
      main_commander_id {3}
      sub_commander_id {4}
    end

    trait :unit_3 do
      main_commander_id {5}
      sub_commander_id {6}
    end

    trait :unit_4 do
      main_commander_id {7}
      sub_commander_id {8}
    end

    trait :unit_5 do
      main_commander_id {9}
      sub_commander_id {10}
    end
  end
end
