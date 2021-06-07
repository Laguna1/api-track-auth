class Activity < ApplicationRecord
  belongs_to :user

  has_many :tracks, dependent: :destroy
  validates :name, presence: true
  validates :day, presence: true
end
