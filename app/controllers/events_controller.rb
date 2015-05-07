class EventsController < ApplicationController
  def create
    begin
      Event.create permitted_params
      flash[:notice] = 'Event created successfully!'
    rescue
      flash[:alert] = 'Something went wrong...'
    end

    redirect_to root_path(date: permitted_params[:worked_at])
  end

  def update
    begin
      event = Event.find params[:id]
      event.update_attributes permitted_params
      flash[:notice] = 'Event updated successfully!'
    rescue
      flash[:alert] = 'Something went wrong...'
    end

    redirect_to root_path(date: permitted_params[:worked_at])
  end

  def permitted_params
    params.require(:event).permit :hours, :minutes, :description, :project_id, :user_id, :worked_at, :ot
  end
end
