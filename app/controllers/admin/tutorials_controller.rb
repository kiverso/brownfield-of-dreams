class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    if (id = params[:tutorial][:playlist_id])
      youtube_service(id)
    else
      @tutorial = Tutorial.create(tutorial_params)
    end
    if @tutorial.save
      successful_creation
    else
      unsuccessful_creation
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.update(tutorial_params)
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def youtube_service(id)
    service = YoutubeService.new
    playlist_data = service.import_playlist(id)
    @playlist_video_data = service.import_playlist_items(id, nil)

    @tutorial = Tutorial.create!(title: playlist_data[:title], description: playlist_data[:description],
                                 thumbnail: playlist_data[:thumbnails][:default][:url], playlist_id: id)
    @playlist_video_data[:items].each { |video| @tutorial.import_video(video) }

    while @playlist_video_data[:nextPageToken]
      @playlist_video_data = service.import_playlist_items(id, @playlist_video_data[:nextPageToken])
      @playlist_video_data[:items].each { |video| @tutorial.import_video(video) }
    end
  end

  def successful_creation
    flash[:success] = "Successfully created tutorial. #{
                      view_context.link_to 'View it here.', tutorial_path(@tutorial)}"
    if params[:tutorial][:playlist_id]
      redirect_to admin_dashboard_path
    else
      redirect_to tutorial_path(@tutorial)
    end
  end

  def unsuccessful_creation
    flash[:notice] = @tutorial.errors.full_messages.to_sentence
    redirect_to '/admin/tutorials/new'
  end

  def tutorial_params
    params.require(:tutorial).permit(:tag_list, :title, :description, :thumbnail)
  end
end
