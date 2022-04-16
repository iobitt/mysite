class Task < ApplicationRecord
  has_one :user
  has_many :intervals
  has_many :tasks_tags
  has_many :tags, through: :tasks_tags
  has_many :subtasks, class_name: "Task", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Task", optional: true

  validates :title, presence: true
  validates :deadline, comparison: { greater_than_or_equal_to: :desired_at }, if: -> { deadline && desired_at }

  before_save :set_desired_at

  scope :completed, -> { where('completed is not null') }
  scope :uncompleted, -> { where('completed is null') }

  def complete?
    !!completed
  end

  def complete
    subtasks.each { |subtask| subtask.complete }
    update(completed: Time.zone.now) unless completed
  end

  private

  def set_desired_at
    self.desired_at ||= deadline
  end
end
