class Case < ApplicationRecord
  belongs_to :city

  default_scope { order(date: :desc) }

  validates_uniqueness_of :date
end
