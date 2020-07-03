class Admin::PlaylistController < Admin::BaseController
  def new
    @tutorial = Tutorial.new
  end
end
