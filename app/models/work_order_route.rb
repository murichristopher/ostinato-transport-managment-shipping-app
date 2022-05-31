class WorkOrderRoute < ApplicationRecord
  belongs_to :work_order

  before_validation :calc_elapsed_time
  before_validation :get_carrier_vehicle

  validates :title, length: {maximum: 50}
  validates :carrier_vehicle, :title, :last_location, :date, presence: true
  has_one :carrier_vehicle
  validate :expiration_date_cannot_be_in_the_future


  private

  def expiration_date_cannot_be_in_the_future
    if date.present? && date > Date.today
      errors.add(:date, "não pode ser futura")
    end
  end

  def calc_elapsed_time
    self.elapsed_time = (Date.today - date).to_i
  end

  def get_carrier_vehicle
    self.carrier_vehicle = work_order.carrier_vehicle
  end
end
