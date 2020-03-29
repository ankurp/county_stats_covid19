class Case < ApplicationRecord
  belongs_to :city

  default_scope { order(date: :desc, created_at: :desc) }

  validates_uniqueness_of :date, scope: :city_id

  after_initialize :set_date_if_empty

  def set_date_if_empty
    self.date ||= Date.today
  end
end
