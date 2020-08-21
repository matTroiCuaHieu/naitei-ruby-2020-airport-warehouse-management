class SchedulesController < ApplicationController
  before_action :logged_in_user, only: :new

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new schedule_params
    if @schedule.save
      redirect_to planes_path
      flash[:success] = t "planes.index.add_success"
    else
      flash[:error] = t "planes.plane.add_fail"
      @plane_id = params.require(:schedule)[:plane_id]
      render "new"
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit Schedule::SCHEDULES_PARAMS
  end
end
