class UserMailer < ApplicationMailer






  def invite(invitee)
    @invitee = invitee

    mail(to: @invitee.email, subject:  'Invitation to join Turing Tutorials')
  end
end
