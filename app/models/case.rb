class Case < ApplicationRecord
  belongs_to :city

  default_scope { order(date: :desc, created_at: :desc) }

  validates_uniqueness_of :date, scope: :city_id
end
