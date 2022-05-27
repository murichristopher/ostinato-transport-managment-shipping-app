class DeliveryTimesController < ApplicationController
  before_action :set_delivery_time, only: [:show, :edit, :update, :destroy]

  def index
    @delivery_times = DeliveryTime.all
  end

  def new
    @delivery_time = DeliveryTime.new
  end

  def show
    @delivery_time = DeliveryTime.find(params[:id])

  end

  def create
    @delivery_time = DeliveryTime.new(delivery_time_params)
    if @delivery_time.save
      redirect_to delivery_index_path
    else
      render :new
    end
  end

  def destroy
    @delivery_time.destroy
    redirect_to delivery_index_path
  end

  private

  def delivery_time_params
    params.require(:delivery_time).permit(:cubic_meters_min, :cubic_meters_max, :weight_min, :weight_max, :value_per_km)
  end

end

