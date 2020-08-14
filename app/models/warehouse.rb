class Warehouse < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :locations, dependent: :destroy
end
