class Earthquake < ApplicationRecord
  VALID_FILTER_MAG_TYPES = %w[md ml ms mw me mi mb mlg].freeze
  self.inheritance_column = nil

  validates :title, :external_url, :place, :mag_type, :latitude, :longitude, presence: true
  validates :magnitude, numericality: { greater_than_or_equal_to: -1.0, less_than_or_equal_to: 10.0 }
  validates :latitude, numericality: { greater_than_or_equal_to: -90.0, less_than_or_equal_to: 90.0 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180.0, less_than_or_equal_to: 180.0 }
  validates :external_id, uniqueness: true

  enum type: { feature: 0 }
end
