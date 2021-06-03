class Activity < ApplicationRecord
  belongs_to :user
  has_many :tracks

  validates :name, presence: true
  validates :day, presence: true
end
