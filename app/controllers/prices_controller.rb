class PricesController < ApplicationController
  def index
    @prices = current_user.transport_company.prices
  end

  def new
    @price = Price.new
  end

  def create
  @price = Price.new(price_params)

  @price.transport_company = current_user.transport_company

    if @price.save
      redirect_to(prices_path, notice:"Preço cadastrado com sucesso!")
    else
      @errors = @price.errors.full_messages
      render :new
    end
  end

  private

  def price_params
    params.require(:price).permit(:cubic_meters_min, :cubic_meters_max, :weight_min, :weight_max, :value_per_km)
  end
end
