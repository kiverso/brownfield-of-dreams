class UsersController < ApplicationController
  def show
    @bookmarks = current_user.bookmarks
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      UserMailer.activation_email(user).deliver_now
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{user.first_name} #{user.last_name}"
      flash[:notice] = "This account has not yet been activated. Please check your email."
      redirect_to dashboard_path
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
