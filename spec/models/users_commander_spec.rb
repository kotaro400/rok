require 'rails_helper'

RSpec.describe UsersCommander, type: :model do
  describe "バリデーション" do
    it "登録直後のスキルレベルは1" do
      users_commander = create(:users_commander)
      expect(users_commander.skill1).to eq 1
      expect(users_commander.skill2).to eq 1
      expect(users_commander.skill3).to eq 1
      expect(users_commander.skill4).to eq 1
    end

    it "スキルレベルは1以上5以下であれば更新可能" do
      users_commander = create(:users_commander)
      users_commander.skill1 = 2
      users_commander.skill1 = 3
      users_commander.skill1 = 4
      users_commander.skill1 = 5
      expect(users_commander).to be_valid
    end

    it "スキルレベルは1未満にならない" do
      users_commander = create(:users_commander)
      users_commander.skill1 = 0
      expect(users_commander).not_to be_valid
    end

    it "スキルレベルは6以上にならない" do
      users_commander = create(:users_commander)
      users_commander.skill1 = 6
      expect(users_commander).not_to be_valid
    end
  end

  describe "#power" do
    it "覚醒レジェンドは20.5" do
      users_commander = create(:users_commander, :full)
      expect(users_commander.power).to eq 20.5
    end

    it "覚醒エピックは20.4" do
      users_commander = create(:users_commander, :full, :epic)
      expect(users_commander.power).to eq 20.4
    end

    it "5554レジェンドより覚醒エピックの方が大きい" do
      epic_users_commander = create(:users_commander, :full, :epic)
      legend_users_commander = create(:users_commander, :full, user: epic_users_commander.user, skill4: 4)
      expect(epic_users_commander.power > legend_users_commander.power).to be_truthy
    end
  end

  describe "#sculpture_count" do
    it "初期状態のレジェンドは690" do
      users_commander = create(:users_commander)
      expect(users_commander.sculpture_count).to eq 690
    end

    it "初期状態のエピックは440" do
      users_commander = create(:users_commander, :epic)
      expect(users_commander.sculpture_count).to eq 440
    end

    it "覚醒指揮官は0" do
      legend_users_commander = create(:users_commander, :full)
      epic_users_commander = create(:users_commander, :full, :epic)
      expect(legend_users_commander.sculpture_count).to eq 0
      expect(epic_users_commander.sculpture_count).to eq 0
    end

    it "5511のレジェンド指揮官は500" do
      users_commander = create(:users_commander, skill1: 5, skill2: 5)
      expect(users_commander.sculpture_count).to eq 500
    end
  end

  describe "#update_users_commander" do
    it "スキルレベルのアップができる" do
      users_commander = create(:users_commander)
      users_commander.update_users_commander("1", "up")
      expect(users_commander.skill1).to eq 2
    end

    it "スキルレベルのダウンができる" do
      users_commander = create(:users_commander, skill1: 2)
      users_commander.update_users_commander("1", "down")
      expect(users_commander.skill1).to eq 1
    end

    it "覚醒ができる" do
      users_commander = create(:users_commander)
      users_commander.update_users_commander("", "full")
      expect(users_commander.skill1).to eq 5
      expect(users_commander.skill2).to eq 5
      expect(users_commander.skill3).to eq 5
      expect(users_commander.skill4).to eq 5
    end

    it "無効な変更ならばfalseを返す" do
      users_commander = create(:users_commander)
      expect(users_commander.update_users_commander("1", "down")).to be_falsey
    end
  end
end