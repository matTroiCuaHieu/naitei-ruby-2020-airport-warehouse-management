class Location < ApplicationRecord
  belongs_to :warehouse
  has_many :schedules, dependent: :destroy
  has_many :locations, through: :schedules

  delegate :name, to: :warehouse, prefix: true, allow_nil: true
end
