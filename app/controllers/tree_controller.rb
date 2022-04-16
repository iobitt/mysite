# frozen_string_literal: true

class TreeController < ApplicationController
  layout 'application'

  def index
    respond_to do |format|
      format.html
      format.json { render :json => tree_data }
    end
  end

  private

  def tree_data
    data = {
      id: 0,
      name: 'Все задачи',
      data: {},
      children: []
    }
    @current_user.tasks.where(parent_id: nil).each { |task| data[:children] << get_task_info(task) }
    data
  end

  def get_task_info(task)
    data = {
      id: task.id,
      name: task.title[0..30],
      data: {},
      children: []
    }
    task.subtasks.each { |subtask| data[:children] << get_task_info(subtask) }
    data
  end
end
