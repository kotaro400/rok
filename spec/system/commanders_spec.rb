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
      Capybara.current_window.resize_to(1280, 1000)
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

    context "招集済みの場合" do
      before do
        visit commander_path("源義経")
        click_on "招集する"
      end

      it "スキルアップが可能" do
        find("#skill1-up").click
        expect(page).to have_selector "#skill1", text: 2
      end

      it "スキルダウンが可能" do
        find("#skill1-up").click
        find("#skill1-down").click
        expect(page).to have_selector "#skill1", text: 1
      end

      it "覚醒が可能" do
        find("#full-up").click
        expect(page).to have_selector "#skill1", text: 5
        expect(page).to have_selector "#skill2", text: 5
        expect(page).to have_selector "#skill3", text: 5
        expect(page).to have_selector "#skill4", text: 5
      end

      describe "検索機能" do
        before do
          visit commander_path("エセルフレッド")
          click_on "招集する"
          find("#full-up").click
          visit commanders_path
        end

        it "デフォルトはスキルレベル順で表示される" do
          expect(all("#owned-commanders-wrapper a")[0]).to have_content "エセルフレッド"
          expect(all("#owned-commanders-wrapper a")[1]).to have_content "源義経"
        end

        it "未招集を選択すると招集済み指揮官は表示されない" do
          select "未招集", from: "type"
          click_on "表示"
          expect(page).not_to have_content "エセルフレッド"
          expect(page).not_to have_content "源義経"
        end

        it "レジェンドを選択するとエピック指揮官は表示されない" do
          select "レジェンド", from: "type"
          click_on "表示"
          expect(page).not_to have_content "ベリサリウス"
        end

        it "エピックを選択するとレジェンド指揮官は表示されない" do
          select "エピック", from: "type"
          click_on "表示"
          expect(page).not_to have_content "エセルフレッド"
        end
      end
    end
  end
end
