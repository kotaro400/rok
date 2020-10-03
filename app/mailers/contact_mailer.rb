class ContactMailer < ApplicationMailer

  def send_contact_mail(content)
    @content = content
    mail(
      to: ENV["ADDRESS"],
      subject: "Prosperity of Kingdoms"
    )
  end

end
