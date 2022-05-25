class CarrierVehicle < ApplicationRecord

  extend FriendlyId
  friendly_id :license_plate, use: :slugged

  belongs_to :transport_company

  validates :license_plate, :brand, :model, :year, :maximum_load_capacity, presence: true
  validates :license_plate, uniqueness:true
  validates :license_plate, format: { with: /\A[a-zA-Z]{3}[0-9][A-Za-z0-9][0-9]{2}\z/ }
  validates :year, length: {is: 4}

  def full_description
    "#{self.model} | #{self.brand}"
  end

  before_create :upcase_license_plate

  private

  def upcase_license_plate
    self.license_plate = self.license_plate.upcase
  end


end
