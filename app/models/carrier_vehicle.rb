class CarrierVehicle < ApplicationRecord

  extend FriendlyId
  friendly_id :slugging, use: [:slugged, :history, :finders]

  belongs_to :transport_company
  belongs_to :work_order, optional: true
  belongs_to :work_order_route, optional: true

  validates :license_plate, :brand, :model, :year, :maximum_load_capacity, presence: true
  validates :license_plate, format: { with: /\A[a-zA-Z]{3}[0-9][A-Za-z0-9][0-9]{2}\z/ }
  validates :year, length: {is: 4}
  validates :maximum_load_capacity, numericality: { greater_than_or_equal_to: 0 }

  def full_description
    "#{self.model} | #{self.brand}"
  end

  before_create :upcase_license_plate

  private

  def upcase_license_plate
    self.license_plate = self.license_plate.upcase
  end


end
