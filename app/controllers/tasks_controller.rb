class TasksController < ApplicationController

  def index
    @tasks = @current_user.tasks.uncompleted.all
  end

  def new
    @task = @current_user.tasks.new
  end

  def create
    @task = @current_user.tasks.new(task_params)

    # TODO: desired_at, deadline сохраняются с неверным смещением времени
    if @task.save
      redirect_to tasks_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    task
  end

  def update
    if task.update(task_params)
      redirect_to tasks_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def complete
    if task.update(completed: Time.zone.now)
      # TODO: сделать вывод в представлении
      flash[:notice] = 'Задача успешно завершена'
    else
      flash[:error] = 'Не удалось завершить задачу'
    end
    redirect_to tasks_path
  end

  private

  def task
    @task ||= @current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :desired_at, :deadline)
  end
end
