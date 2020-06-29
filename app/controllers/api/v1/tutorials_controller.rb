class Api::V1::TutorialsController < ApplicationController
  def index
    render json: Tutorial.all
  end

  def show
    render json: Tutorial.find(params[:id])
    #this is a comment
  end
end
