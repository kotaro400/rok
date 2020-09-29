FactoryBot.define do
  factory :unit do
    id = Commander.first.id

    sequence(:main_commander_id) {|n| id + n % 30 }
    sequence(:sub_commander_id) {|n| id + n % 30 + 1 }

    trait :unit_1 do
      main_commander_id {id}
      sub_commander_id {id + 1}
    end

    trait :unit_2 do
      main_commander_id {id + 2}
      sub_commander_id {id + 3}
    end

    trait :unit_3 do
      main_commander_id {id + 4}
      sub_commander_id {id + 5}
    end

    trait :unit_4 do
      main_commander_id {id + 6}
      sub_commander_id {id + 7}
    end

    trait :unit_5 do
      main_commander_id {id + 8}
      sub_commander_id {id + 9}
    end
  end
end
