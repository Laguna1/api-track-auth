class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :email, presence: true
  validates :password_digest, presence: true, length: { minimum: 6 }
end
