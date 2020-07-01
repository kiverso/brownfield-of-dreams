class WelcomeController < ApplicationController
  def index
    @tutorials = if params[:tag]
                   Tutorial.authorized_for_viewer(current_user)
                           .tagged_with(params[:tag])
                           .paginate(page: params[:page], per_page: 5)
                 else
                   Tutorial.authorized_for_viewer(current_user)
                           .paginate(page: params[:page], per_page: 5)
                 end
  end
end
