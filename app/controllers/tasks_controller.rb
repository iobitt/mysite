class TasksController < ApplicationController

  helper_method :intervals, :subtasks, :tags, :active_tag

  def index
    if params[:parent_id].present?
      task = @current_user.tasks.find(params[:parent_id])
      @tasks = [task] + task.subtasks
      return
    end

    if active_tag
      @tasks = active_tag.tasks
    else
      @tasks = @current_user.tasks
    end

    if params[:desired_at].present?
      case params[:desired_at]
      when 'today'
        @tasks = @tasks.where('desired_at < ?', Time.zone.tomorrow)
      when '3day'
        @tasks = @tasks.where('desired_at < ?', Time.zone.today + 3.days)
      when 'week'
        @tasks = @tasks.where('desired_at < ?', Time.zone.today + 7.days)
      end
    end

    if params.key? :completed
      @tasks = @tasks.completed.order(completed: :desc)
    else
      @tasks = @tasks.uncompleted.order(:desired_at, :deadline)
    end
  end

  def new
    @task = @current_user.tasks.new(title: params[:title])
  end

  def create
    @task = @current_user.tasks.new(task_params)
    if @task.parent
      @task.desired_at ||= @task.parent.desired_at
      @task.deadline ||= @task.parent.deadline
    end

    if @task.save
      @task.tags << @task.parent.tags if @task.parent
      redirect_to edit_task_path(@task)
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
    if task.complete
      # TODO: сделать вывод в представлении
      flash[:notice] = 'Задача успешно завершена'
    else
      flash[:error] = 'Не удалось завершить задачу'
    end
    redirect_to tasks_path
  end

  def add_tag
    tag = @current_user.tags.find(params[:tag_id])
    tasks_tags = TasksTag.where(tag_id: tag.id, task_id: task.id)
    # TODO: удалять нормально
    if tasks_tags.present?
      tasks_tags.delete_all
    else
      task.tags << tag
    end
    # TODO: сделать через render
    redirect_to task_path(task)
  end

  private

  def task
    @task ||= @current_user.tasks.find(params[:id])
  end

  def subtasks
    @subtasks = task.subtasks
  end

  def intervals
    task.intervals.order(:start_at)
  end

  def tags
    @tags ||= @current_user.tags.order(:name)
  end

  def active_tag
    @active_tag ||= tags.find_by(id: params[:tag_id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :parent_id, :desired_at, :deadline)
  end
end
