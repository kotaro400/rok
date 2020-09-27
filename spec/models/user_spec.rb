require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    it "ユーザーネームとパスワードがあれば登録可能" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "ユーザーネームがない場合登録できない" do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it "パスワードがない場合登録できない" do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it "パスワードが6文字以下の場合登録できない" do
      user = build(:user, password: "pwd")
      expect(user).not_to be_valid
    end

    it "すでにユーザーネームが存在する場合、同じユーザーネームで登録できない" do
      user = create(:user)
      new_user = build(:user, name: user.name)
      expect(new_user).not_to be_valid
    end
  end

  describe "#commanders_sorted_by_skill" do
    it "所持している指揮官をレアリティ、スキルレベル順でソートする" do
      user = create(:user)
      full_epic_commander = create(:users_commander, :epic, :full, user: user)
      full_legend_commander = create(:users_commander, :full, user: user)
      legend_commander = create(:users_commander, user: user)
      expect(user.commanders_sorted_by_skill).to eq [full_legend_commander, full_epic_commander, legend_commander]
    end
  end
end
