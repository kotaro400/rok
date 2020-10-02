require 'rails_helper'

RSpec.describe 'Teams', type: :system do
  context "ログインしていない場合" do
    it "トップから編成をクリックしてもリダイレクトされる" do
      visit root_path
      click_on "編成"
      expect(page).to have_content "ログイン"
    end

    it "編成詳細ページを見ることができない" do
      team = create(:team)
      visit team_path(team)
      expect(page).to have_content "ログイン"
    end

    it "編成作成ページを見ることができない" do
      visit new_team_path
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

    it "トップからマイ編成に遷移可能" do
      click_on "編成"
      expect(current_path).to eq teams_path
    end

    it "新しく編成を追加できる" do
      visit teams_path
      click_on "➕"
      fill_in "編成名", with: "黄昏の峡谷"
      select "源義経", from: "team[unit1_main]"
      select "曹操", from: "team[unit1_sub]"
      select "カール・マルテル", from: "team[unit2_main]"
      select "リチャード1世", from: "team[unit2_sub]"
      fill_in "説明", with: "黄昏の峡谷用の編成です"
      click_on "保存する"
      expect(page).to have_content "編成が作成されました"
      expect(current_path).to eq teams_path
      expect(page).to have_content "黄昏の峡谷"
    end

    it "編成名なしでは作成できない" do
      visit teams_path
      click_on "➕"
      click_on "保存する"
      expect(page).to have_content "編成名を入力してください"
    end

    describe "編成詳細ページ" do
      before do
        @team = create(:team, user: @user)
        visit team_path(@team)
      end

      it "覚醒に必要な彫像数が表示されている" do
        expect(page).to have_content "レジェンド英雄像 #{@team.team_sculpture_count(@user.id, "レジェンド")}個"
        expect(page).to have_content "エピック英雄像 #{@team.team_sculpture_count(@user.id, "エピック")}個"
      end

      it "編成の削除ができる" do
        page.accept_confirm do
          click_on "この編成を削除"
        end
        expect(page).to have_content "編成を削除しました"
        expect(page).not_to have_content "黄昏の峡谷"
      end
    end

    describe "編成の編集" do
      before do
        @team = create(:team, user: @user)
        visit team_path(@team)
      end

      it "編成の編集が可能" do
        click_on "この編成を編集"
        select "ベリサリウス", from: "team[unit1_main]"
        click_on "保存する"
        expect(page).to have_content "編成を保存しました"
        expect(page).to have_content "ベリサリウス"
      end

      it "編成名を空にすることはできない" do
        click_on "この編成を編集"
        fill_in "編成名", with: nil
        click_on "保存する"
        expect(page).to have_content "編成名を入力してください"
      end
    end
  end
end
