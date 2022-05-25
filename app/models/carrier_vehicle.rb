class CarrierVehicle < ApplicationRecord
  belongs_to :transport_company

  validates :license_plate, :brand, :model, :year, :maximum_load_capacity, presence: true
  validates :license_plate, uniqueness:true
  validates :license_plate, format: { with: /\A[a-zA-Z]{3}[0-9][A-Za-z0-9][0-9]{2}\z/ }
  validates :year, length: {is: 4}



end
