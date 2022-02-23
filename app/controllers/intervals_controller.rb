class IntervalsController < ApplicationController

  def new
    @interval = intervals.new
  end

  def create
    @interval = intervals.new(interval_params)

    unless @interval.save
      flash[:error] = @interval.errors.full_messages.first
    end
    redirect_to edit_task_path(task)
  end

  private

  def task
    @task ||= @current_user.tasks.find(params[:interval][:task_id])
  end

  def intervals
    task.intervals
  end

  def interval
    @interval ||= intervals.find(params[:id])
  end

  def interval_params
    params.require(:interval).permit(:task_id, :start_at, :end_at)
  end
end
