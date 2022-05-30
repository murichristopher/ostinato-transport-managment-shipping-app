class WorkOrderRoute < ApplicationRecord
  belongs_to :work_order

  before_validation :calc_elapsed_time
  before_validation :get_carrier_vehicle

  validates :title, length: {maximum: 50}
  validates :carrier_vehicle, :title, :last_location, presence: true
  has_one :carrier_vehicle


  private

  def calc_elapsed_time
    self.elapsed_time = (Date.today - date).to_i
  end

  def get_carrier_vehicle
    self.carrier_vehicle = work_order.carrier_vehicle
  end
end
