require 'rails_helper'

RSpec.describe 'Rank', type: :system do
  describe "ランクアップコスト計算" do
    before do
      visit root_path
      click_on "ランクアップコスト"
    end

    it "ランクアップコストの計算ができる" do
      select "50", from: "level"
      click_on "計算する"
      expect(page).to have_content "星の勲章があと平均407個"
      expect(page).to have_content "星の勲章があと最悪650個"
    end

    it "未入力でも計算できる" do
      click_on "計算する"
      expect(page).to have_content "星の勲章があと平均4個"
      expect(page).to have_content "星の勲章があと最悪5個"
    end
  end
end
