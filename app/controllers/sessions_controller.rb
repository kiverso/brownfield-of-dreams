class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Looks like your email or password is invalid'
      render :new
    end
  end

  def update
    token = request.env['omniauth.auth'][:credentials][:token]
    url = request.env['omniauth.auth'][:extra][:raw_info][:html_url]

    current_user.update_columns(:token => token, :url => url)
    current_user.save
    flash[:success] = 'Connected to Github!'
    redirect_to dashboard_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
