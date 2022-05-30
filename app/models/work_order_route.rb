class WorkOrderRoute < ApplicationRecord
  belongs_to :work_order

  before_validation :calc_elapsed_time

  validates :title, length: {maximum: 50}



  private

  def calc_elapsed_time
    self.elapsed_time = (Date.today - date).to_i
  end
end
