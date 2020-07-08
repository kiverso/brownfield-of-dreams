class UserMailer < ApplicationMailer






  
  def invite(invite)
    @invite = invite

    mail(to: @invite.recipient_email, subject:  'Invitation to join Turing Tutorials')
  end
end
