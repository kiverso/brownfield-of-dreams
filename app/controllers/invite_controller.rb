class InviteController < ApplicationController
  def show
    render file: 'public/404.html' unless current_user
  end

  def create
    invitee_github = params[:invitee_github]
    binding.pry
  end
end
