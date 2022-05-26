class PricesController < ApplicationController
  def index
    @prices = current_user.transport_company.prices
  end
end
