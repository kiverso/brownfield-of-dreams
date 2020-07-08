class InviteController < ApplicationController
  def show
    render file: 'public/404.html' unless current_user
  end

  def create
    github_service = GithubService.new
    recipient = github_service.get_json("users/#{params[:invitee_github]}", current_user)
    inviter = github_service.get_json('user', current_user)
    invite = Invite.new(inviter, recipient)
    UserMailer.invite(invite).deliver_now
    flash[:success] = 'Successfully sent invite!'
    redirect_to dashboard_path
  end
end
