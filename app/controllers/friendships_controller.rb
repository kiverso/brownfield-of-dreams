class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(url: params[:friend_url])
    friendship = Friendship.create(user_id: current_user.id, friend_id: friend.id)
    friendship2 = Friendship.create(user_id: friend.id, friend_id: current_user.id)
    if friendship.save && friendship2.save
      flash[:success] = "Successfully added #{friend.first_name} #{friend.last_name} as a friend"
    else
      flash[:alert] = friendship.errors.full_messages.to_sentence
    end
    redirect_to dashboard_path
  end
end
