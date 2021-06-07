class Track < ApplicationRecord
  belongs_to :activity

  validates :name, presence: true
  validates :duration, presence: true
  validates :distance, presence: true
end
