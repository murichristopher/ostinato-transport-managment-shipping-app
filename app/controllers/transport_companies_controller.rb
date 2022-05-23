class TransportCompaniesController < ApplicationController
  before_action :authenticate_user!, :except => [:index]

  def index
    @transport_companies = TransportCompany.all
  end
end
