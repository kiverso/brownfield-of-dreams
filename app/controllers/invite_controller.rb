class InviteController < ApplicationController
  def show
    render file: 'public/404.html' unless current_user
  end
