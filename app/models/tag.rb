class Tag < ApplicationRecord
  has_one :user
  has_and_belongs_to_many :tasks

  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: { scope: :user }
end
