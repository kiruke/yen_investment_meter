class AssetPrice < ApplicationRecord
  validates :price_date, presence: true
  validates :asset_type, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :unit, presence: true
  
  VALID_ASSET_TYPES = %w[usd_jpy gold nikkei225 dow_jones].freeze
  validates :asset_type, inclusion: { in: VALID_ASSET_TYPES }
end
