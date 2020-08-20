class Location < ApplicationRecord
  belongs_to :warehouse
  has_many :schedules, dependent: :destroy
  has_many :planes, through: :schedules

  scope :gara_false, ->{where(warehouse_id: Settings.warehouse.gara, filled: Settings.condition.false)}
  scope :ready_false, ->{where(warehouse_id: Settings.warehouse.ready, filled: Settings.condition.false)}

  delegate :name, to: :warehouse, prefix: true, allow_nil: true

  def id_initial
    id.to_s
  end
end
