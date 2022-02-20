require 'digest/sha1'

class User < ApplicationRecord
  has_secure_password
  has_many :tasks

  validates :nickname, :email, :password_confirmation, presence: true
  validates :nickname, length: { in: 3..20 }
  validates :password, length: { in: 8..70 }
  validates :nickname, :email, uniqueness: true
end
