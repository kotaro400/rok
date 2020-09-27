require 'rails_helper'

RSpec.describe Commander, type: :model do
  describe "バリデーション" do
    it "名前、レアリティがあれば作成可能" do
      commander = build(:commander)
      expect(commander).to be_valid
    end

    it "名前がなければ作成できない" do
      commander = build(:commander, name: nil)
      expect(commander).not_to be_valid
    end

    it "レアリティがなければ作成できない" do
      commander = build(:commander, rarity: nil)
      expect(commander).not_to be_valid
    end

    it "レアリティがレジェンド、エピック以外ならば作成できない" do
      commander = build(:commander, rarity: "レア")
      expect(commander).not_to be_valid
    end

    it "同じ名前の指揮官は作成できない" do
      commander = create(:commander)
      new_commander = build(:commander, name: commander.name)
      expect(new_commander).not_to be_valid
    end
  end

  describe "#max_sculpture_count" do
    it "レジェンドならば700" do
      commander = Commander.find_by(rarity: "レジェンド")
      expect(commander.max_sculpture_count).to eq 700
    end

    it "エピックならば450" do
      commander = Commander.find_by(rarity: "エピック")
      expect(commander.max_sculpture_count).to eq 450
    end
  end

end
