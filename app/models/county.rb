class County < ApplicationRecord
  belongs_to :state
  has_many :cities
end
