class Plane < ApplicationRecord
  has_many :requests, dependent: :destroy
  has_many :locations, through: :requests
  enum status: {gara: "in gara", ready: "ready"}

  validates :status, presence: true

  def id_initial
    id.to_s
  end
end
