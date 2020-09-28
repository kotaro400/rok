require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe "新規登録" do
    scenario "ユーザーが新規登録する" do
      visit "/users/sign_up"
      fill_in "ユーザーネーム", with: "rairaikinn"
      fill_in "パスワード", with: "password"
      fill_in "確認用パスワード", with: "password"
      click_button "登録する"
      expect(page).to have_content "登録が完了しました"
      expect(current_path).to eq root_path
    end

    scenario "登録に失敗する" do
      visit "/users/sign_up"
      fill_in "ユーザーネーム", with: "rairaikinn"
      fill_in "パスワード", with: "password"
      fill_in "確認用パスワード", with: ""
      click_button "登録する"
      expect(page).to have_content "新規登録"
      expect(page).to have_selector "#error_explanation"
    end
  end

  describe "ログイン" do
    before do
      @user = create(:user)
    end
    scenario "ユーザーがログインする" do
      visit "/users/sign_in"
      fill_in "ユーザーネーム", with: @user.name
      fill_in "パスワード", with: @user.password
      click_button "ログイン"
      expect(page).to have_content "ログインしました"
      expect(current_path).to eq root_path
    end

    scenario "ユーザーがログインに失敗する" do
      visit "/users/sign_in"
      fill_in "ユーザーネーム", with: @user.name
      fill_in "パスワード", with: "pwd"
      click_button "ログイン"
      expect(current_path).to eq new_user_session_path
      expect(page).to have_selector ".alert"
    end
  end
end
