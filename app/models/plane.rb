class Plane < ApplicationRecord
  has_many :schedules, dependent: :destroy
  has_many :locations, through: :schedules
  enum status: {Gara: "in gara", Ready: "ready"}
end
