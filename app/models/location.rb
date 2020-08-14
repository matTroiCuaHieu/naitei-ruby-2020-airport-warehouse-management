class Location < ApplicationRecord
  belongs_to :warehouse
  has_many :schedules, dependent: :destroy
  has_many :locations, through: :schedules
end
