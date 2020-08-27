class Request < ApplicationRecord
  REQUESTS_PARAMS = %i(plane_id location_id user_id reason).freeze

  enum status: {process: "processing", accepted: "accepted", denied: "denied"}

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
  validates :reason, presence: true, if: :denied?

  delegate :code, to: :plane, prefix: true, allow_nil: true
  delegate :name, to: :user, prefix: true, allow_nil: true

  def update_value? request, current_user
    @plane = Plane.find_by id: request.plane_id
    @old_location = Location.find_by id: @plane.requests.accepted.last.location_id
    @new_location = Location.find_by id: request.location_id
    ActiveRecord::Base.transaction do
      update_value_request request, current_user
      @old_location.update!(filled: false)
      @new_location.update!(filled: true)
    end
  rescue ActiveRecord::RecordInvalid => e
    logger.error e.message
  end

  private

  def update_value_request request, current_user
    request.update!(status: Settings.request.status.accepted, approver: current_user.name)
    if @plane.ready?
      @plane.update!(status: Settings.plane.status.gara)
    else
      @plane.update!(status: Settings.plane.status.ready)
    end
  end
end
