class UserMailer < ApplicationMailer

  def invite(invite)
    @invite = invite

    mail(to: @invite.recipient_email, subject:  'Invitation to join Turing Tutorials')
  def activation_email(user)
    @user = user
    mail(to: @user.email, subject: "Youtube Emporium Activation Link")
  end
end
