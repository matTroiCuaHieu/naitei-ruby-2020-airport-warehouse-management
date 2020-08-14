class Component < ApplicationRecord
  has_many :histories, dependent: :destroy
  has_many :schedules, through: :histories
end
