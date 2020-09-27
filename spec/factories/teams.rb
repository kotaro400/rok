FactoryBot.define do
  factory :team do
    title {"黄昏の峡谷"}
    details {"黄昏の峡谷用の編成です"}
    unit1_id {create(:unit, :unit_1).id}
    unit2_id {create(:unit, :unit_2).id}
    unit3_id {create(:unit, :unit_3).id}
    unit4_id {create(:unit, :unit_4).id}
    unit5_id {create(:unit, :unit_5).id}
    association :user
  end
end
