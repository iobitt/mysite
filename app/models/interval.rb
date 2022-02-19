class Interval < ApplicationRecord
  has_one :task

  validates :start_at, presence: true, comparison: { greater_than: :end_date }
  validates :end_at, presence: true
end
