require 'rails_helper'

RSpec.describe Team, type: :model do
  describe "バリデーション" do
    it "編成名があれば作成可能" do
      team = build(:team, details: nil, unit1_id: nil)
      expect(team).to be_valid
    end

    it "編成名がなければ作成できない" do
      team = build(:team, title: nil)
      expect(team).not_to be_valid
    end

    it "編成名は31文字以上だと作成できない" do
      team = build(:team, title: "a" * 31)
      expect(team).not_to be_valid
    end

    it "編成の説明は301文字だと作成できない" do
      team = build(:team, details: "a" * 301)
      expect(team).not_to be_valid
    end

    it "同一編成内には同じ指揮官を含まない" do
      unit_1 = create(:unit, main_commander_id: 1)
      unit_2 = create(:unit, main_commander_id: 1)
      team = build(:team, unit1_id: unit_1.id, unit2_id: unit_2.id)
      expect(team).not_to be_valid
    end
  end

  describe "#units" do
    it "5部隊あれば、5部隊の配列を返す" do
      team = create(:team)
      expect(team.units.size).to eq 5
    end

    it "3部隊しかなければ、3部隊の配列を返す" do
      team = create(:team, unit4_id: nil, unit5_id: nil)
      expect(team.units.size).to eq 3
    end
  end

  describe "#commanders" do
    it "編成に含まれる指揮官の配列を返す" do
      team = create(:team)
      expect(team.commanders.length).to eq 10
    end
  end

  describe "#not_owned_commanders" do
    it "編成内の未所持の指揮官を返す" do
      team = create(:team)
      users_commander = create(:users_commander, user: team.user, commander: team.commanders.first)
      expect(team.not_owned_commanders(team.user.id).length).to eq 9
    end
  end

  describe "#team_sculpture_count" do
    it "すべてレジェンドで未所持の場合は6900を返す" do
      team = create(:team)
      expect(team.team_sculpture_count(team.user.id, "レジェンド")).to eq 6900
    end

    it "すべてレジェンドで覚醒指揮官1人所持、他未所持のときは6210を返す" do
      team = create(:team)
      users_commander = create(:users_commander, :full, user: team.user, commander: team.commanders.first)
      expect(team.team_sculpture_count(team.user.id, "レジェンド")).to eq 6210
    end
  end
end
