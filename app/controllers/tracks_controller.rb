class TracksController < ApplicationController
  before_action :find_activity
  before_action :find_track, only: %i[index show update destroy]

  def index
    render json: @activity.tracks
  end

  def show
    render json: @track
  end

  def create
    @track = Track.new(track_params)

    if @track.save
      render json: @track
    else

      render json: { error: 'Unable to create Date' }, status: 400
    end
  end

  def update
    if @track
      @track.update(track_params)
      render json: { message: 'Date succesfully updated' }, status: 200
    else
      render json: { error: 'Unable to update Date' }, status: 400
    end
  end

  def destroy
    if @track
      @track.destroy
      render json: { message: 'Date succesfully deleted' }, status: 200
    else

      render json: { error: 'Unable to delete Date' }, status: 400
    end
  end

  private

  def track_params
    params.require(:track).permit(:name, :duration, :distance, :completed, :activity_id, :id)
  end

  def find_track
    @track = Track.find(params[:id])
  end

  def find_activity
    @activity = Activity.find(params[:activity_id])
  end
end
