class Schedule < ApplicationRecord
  SCHEDULES_PARAMS = %i(plane_id location_id user_id reason).freeze

  belongs_to :location
  belongs_to :plane
  belongs_to :user
  has_many :components, through: :histories

  validates :plane_id, presence: true,
    Numericality: {greater_than: Settings.validation.id, only_integer: true},
    allow_nil: true
  validates :location_id, presence: true,
    Numericality: {greater_than: Settings.validation.id, only_integer: true},
    allow_nil: true
  validates :user_id, presence: true,
    Numericality: {greater_than: Settings.validation.id, only_integer: true},
    allow_nil: true
  validates :reason, presence: true,
    length: {maximum: Settings.reason.max_length}

  delegate :code, to: :plane, prefix: true, allow_nil: true
end
