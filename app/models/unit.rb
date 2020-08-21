class Unit < ApplicationRecord
  has_many :users, dependent: :destroy
end
