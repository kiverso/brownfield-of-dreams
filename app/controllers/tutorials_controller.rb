class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if !current_user && tutorial.classroom == true
      render file: 'public/404'
    else
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    end
  end
end
