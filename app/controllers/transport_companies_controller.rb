class TransportCompaniesController < ApplicationController
  before_action :authenticate_admin!, :except => [:index]

  def index
    @transport_companies = TransportCompany.all
  end

  def new
    @transport_company = TransportCompany.new
  end

  def create
    @transport_company = TransportCompany.new(transport_company_params)

    if @transport_company.save
      redirect_to(@transport_company, notice:"Transportadora cadastrada com sucesso!")
    else
      @errors = @transport_company.errors.full_messages
      flash[:error] = "Algo deu errado"
      render 'new'
    end
  end

  def show
    @transport_company = TransportCompany.find(params[:id])
  end


  private

  def transport_company_params
    params.require(:transport_company).permit(:trading_name, :company_name, :domain, :registration_number, :full_address)
  end


end
