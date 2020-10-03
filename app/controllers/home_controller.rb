class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def top
  end

  def contact
    if params[:content].present?
      ContactMailer.send_contact_mail(params[:content]).deliver_later
      redirect_to root_path, notice: "送信しました"
    else
      redirect_to root_path, alert: "本文を入力してください"
    end
  end

end
