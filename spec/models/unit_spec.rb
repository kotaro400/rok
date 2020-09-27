require 'rails_helper'

RSpec.describe Unit, type: :model do
  describe "バリデーション" do
    it "主将と副将がいれば作成可能" do
      unit = build(:unit)
      expect(unit).to be_valid
    end

    it "副将がいなくても作成可能" do
      unit = create(:unit, sub_commander_id: nil)
      expect(unit).to be_valid
    end

    it "主将がいなければ作成できない" do
      unit = build(:unit, main_commander_id: nil)
      expect(unit).not_to be_valid
    end

    it "主将と副将が同じ部隊は作成できない" do
      unit = build(:unit)
      unit.sub_commander_id = unit.main_commander_id
      expect(unit).not_to be_valid
    end

    it "すでに同じ部隊がある場合は作成できない" do
      unit = create(:unit)
      new_unit = build(:unit, main_commander_id: unit.main_commander_id, sub_commander_id: unit.sub_commander_id)
      expect(new_unit).not_to be_valid
    end
  end

  describe "#create_units" do
    before do
      Unit.destroy_all
      @team_params = {
        unit1_main: 1,
        unit1_sub: 2,
        unit2_main: 3,
        unit2_sub: 4,
        unit3_main: 5,
        unit3_sub: 6,
        unit4_main: 7,
        unit4_sub: 8,
        unit5_main: 9,
        unit5_sub: 10,
      }
    end
    it "5部隊すべて未作成ならば5部隊作成し、部隊idの配列を返す" do
      expect(Unit.create_units(@team_params).length).to eq 5
      expect(Unit.all.size).to eq 5
    end

    it "部隊がすでに存在すれば新規に作成しない" do
      create(:unit, main_commander_id: 1, sub_commander_id: 2)
      expect{ Unit.create_units(@team_params) }.to change{ Unit.count }.by(4)
    end

    it "部隊の作成ができなければ、該当するインスタンスが返る" do
      @team_params[:unit1_sub] = 1
      expect(Unit.create_units(@team_params).main_commander_id).to eq 1
      expect(Unit.create_units(@team_params).sub_commander_id).to eq 1
    end
  end

  describe "#main_commander" do
    it "主将のインスタンスを返す" do
      unit = create(:unit)
      expect(unit.main_commander.class).to eq Commander
    end
  end

  describe "#sub_commander" do
    it "副将のインスタンスを返す" do
      unit = create(:unit)
      expect(unit.sub_commander.class).to eq Commander
    end
  end
end
