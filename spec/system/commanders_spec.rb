require 'rails_helper'

RSpec.describe 'Commanders', type: :system do
  context "ログインしていない場合" do
    it "トップページのリンクをクリックしてもログイン画面にリダイレクトされる" do
      visit root_path
      click_on "指揮官"
      expect(page).to have_content "ログイン"
    end

    it "指揮官詳細画面に飛ぼうとしてもリダイレクトされる" do
      visit "/commanders/源義経"
      expect(page).to have_content "ログイン"
    end
  end

  context "ログインしている場合" do
    before do
      @user = create(:user)
      visit "/users/sign_in"
      fill_in "ユーザーネーム", with: @user.name
      fill_in "パスワード", with: @user.password
      click_button "ログイン"
    end

    it "トップから指揮官一覧に飛べる" do
      click_on "指揮官"
      expect(current_path).to eq commanders_path
    end

    it "指揮官の詳細画面に飛べる" do
      visit "/commanders"
      click_on "源義経"
      expect(current_path).to eq commander_path("源義経")
    end

    it "未招集の指揮官を招集することができる" do
      visit commander_path("源義経")
      click_on "招集する"
      expect(page).not_to have_content "招集する"
    end
  end
end
