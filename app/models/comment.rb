class Comment < ApplicationRecord
  include Visible

  belongs_to :article

  validates :commenter, :body, presence: true
end
