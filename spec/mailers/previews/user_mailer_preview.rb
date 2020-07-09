# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def invite_email
    UserMailer.invite(Invite.new({name: 'Kyle Iverson'}, {name: 'Jeff', email: 'jeff@example.com'}))
  end
end
