class Schedule < ApplicationRecord
  belongs_to :location
  belongs_to :plane
  has_many :components, through: :histories
end
