class History < ApplicationRecord
  belongs_to :request
  belongs_to :component
end
