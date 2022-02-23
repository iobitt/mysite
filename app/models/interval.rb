class Interval < ApplicationRecord
  has_one :task

  validates :start_at, presence: true
  validates :end_at, presence: true, comparison: { greater_than: :start_at }
end
