class TracksController < ApplicationController
  before_action :set_activity
  before_action :set_activity_track, only: [:show, :update, :destroy]

  # GET /activities/:activity_id/tracks
  def index
    json_response(@activity.tracks)
  end

  # GET /activities/:activity_id/tracks/:id
  def show
    json_response(@track)
  end

  # POST /activities/:activity_id/tracks
  def create
    @activity.tracks.create!(track_params)
    json_response(@activity, :created)
  end

  # PUT /activities/:activity_id/tracks/:id
  def update
    @track.update(track_params)
    head :no_content
  end

  # DELETE /activities/:activity_id/tracks/:id
  def destroy
    @track.destroy
    head :no_content
  end

  private

  def track_params
    params.permit(:name, :distance, :duration, :activity_id)
  end

  def set_activity
    @activity = Activity.find(params[:activity_id])
  end

  def set_activity_track
    @track = @activity.tracks.find_by!(id: params[:id]) if @activity
  end
end
