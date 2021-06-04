class ActivitiesController < ApplicationController
  before_action :find_activity, only: %i[show update destroy]

  def index
    render json: @current_user.activities
  end

  def show
    render json: @activity
  end

  def create
    @activity = current_user.activities.create!(activity_params)

    if @activity.save
      render json: @activity
    else

      render json: { error: 'Unable to create activity' }, status: 400
    end
  end

  def update
    if @activity
      @activity.update(activity_params)
      render json: { message: 'activity succesfully updated' }, status: 200
    else

      render json: { error: 'Unable to update activity' }, status: 400
    end
  end

  def destroy
    if @activity
      @activity.destroy
      render json: { message: 'activity succesfully deleted' }, status: 200
    else

      render json: { error: 'Unable to delete activity' }, status: 400
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :day, :place, :user_id, :id)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_activity
    @activity = Activity.find(params[:id])
  end
end
