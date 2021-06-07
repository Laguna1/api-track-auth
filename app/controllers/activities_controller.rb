class ActivitiesController < ApplicationController
    before_action :set_activity, only: [:show, :update, :destroy]

    # GET /activities
    def index
      @activities = current_user.activities
      json_response(@activities)
    end
  
    # POST /activities
    def create
      @activity = current_user.activities.create!(activity_params)
      json_response(@activity, :created)
    end
  
    # GET /activities/:id
    def show
      json_response(@activity)
    end
  
    # PUT /activities/:id
    def update
      @activity.update(activity_params)
      head :no_content
    end
  
    # DELETE /activities/:id
    def destroy
      @activity.destroy
      head :no_content
    end
  
    private
  
    def activity_params
      # whitelist params
      params.permit(:name, :day, :place, :user_id)
    end
  
    def set_activity
      @activity = Activity.find(params[:id])
    end
end
