class Component < ApplicationRecord
  has_many :histories, dependent: :destroy
  has_many :requests, through: :histories
end
