class Activity < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :day, presence: true
end
