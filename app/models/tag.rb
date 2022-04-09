class Tag < ApplicationRecord
  has_one :user
  has_many :tasks_tags
  has_many :tasks, through: :tasks_tags

  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :user }
end
