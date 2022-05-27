class DeliveryTime < ApplicationRecord
  extend FriendlyId
  friendly_id :slugging, use: [:slugged, :history, :finders]

  belongs_to :transport_company

  validates :km_min, :km_max, :time, presence: true
  validates :km_min, :km_max, :time, numericality: { greater_than_or_equal_to: 0 }
  validate :km_max_cannot_be_less_or_equal_than_km_min

  def km_max_cannot_be_less_or_equal_than_km_min
    if km_max.present? && km_min.present?
      if km_min > km_max or km_min == km_max
        errors.add(:km_max, "deve ser maior que o Quilômetro Mínimo")
      end
    end
  end
end
