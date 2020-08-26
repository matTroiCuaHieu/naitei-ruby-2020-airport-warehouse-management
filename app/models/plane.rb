class Plane < ApplicationRecord
  has_many :requests, dependent: :destroy
  has_many :locations, through: :requests
  enum status: {rara: "in gara", ready: "ready"}

  def id_initial
    id.to_s
  end
end
