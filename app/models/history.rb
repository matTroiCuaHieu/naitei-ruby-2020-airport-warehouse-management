class History < ApplicationRecord
  belongs_to :schedule
  belongs_to :component
end
