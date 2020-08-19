class Schedule < ApplicationRecord
  belongs_to :location
  belongs_to :plane
  delegate :code, to: :plane, prefix: true, allow_nil: true
  has_many :components, through: :histories
end
