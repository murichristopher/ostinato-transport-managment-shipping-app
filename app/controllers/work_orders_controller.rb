class WorkOrdersController < ApplicationController
  before_action :authenticate_user
  before_action :set_visibility
  before_action :authenticate_admin!, only: [:new]

  def index
  end

  def show
    @work_order = WorkOrder.find(params[:id])
  end


  def new
    @work_order = WorkOrder.new
  end

  def create

    @work_order = WorkOrder.new(work_order_params)
    @work_order.transport_company_id = params[:transport_company_id]

    if @work_order.save
      redirect_to(work_orders_path, notice:"Ordem de Serviço cadastrada com sucesso!")
    else
      @errors = @work_order.errors.full_messages
      render :new
    end
  end

  def edit
    @work_order = WorkOrder.find(params[:id])
  end

  def update
    @work_order = WorkOrder.find(params[:id])
    if @work_order.update_attributes(params[:work_order])
      redirect_to @work_order, :notice  => "Successfully updated work order."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @work_order = WorkOrder.find(params[:id])
    @work_order.destroy
    redirect_to work_orders_url, :notice => "Successfully destroyed work order."
  end

  def set_work_order
    @work_order = WorkOrder.find(params[:id])
  end

  def new_directly_assign
    @work_order = WorkOrder.new
  end

  def create_directly_assign
    @work_order = WorkOrder.new(work_order_params)
    transport_company = TransportCompany.friendly.find(params[:id])

    @work_order.transport_company = transport_company

    if @work_order.save
      redirect_to(@work_order, notice:"Ordem de Serviço cadastrada com sucesso!")
    else
      @errors = @work_order.errors.full_messages
      render :new_directly_assign
    end
  end

  def search
    cubic_size = params[:work_order][:cubic_size]
    total_weight = params[:work_order][:total_weight]
    @total_distance = params[:work_order][:total_distance].to_i

    @budgets = Price.where("cubic_meters_min <= ? AND cubic_meters_max >= ? AND weight_min <= ? AND weight_max >= ?", cubic_size, cubic_size, total_weight, total_weight)


  end

  private

  def work_order_params
    params.require(:work_order).permit(:sender_address, :receiver_address, :receiver_name, :receiver_cpf, :cubic_size, :total_weight, :total_distance)
  end

  def authenticate_user
    if current_user && current_user.guest?
      return redirect_to root_path
    elsif !current_user && !current_admin
      return redirect_to root_path
    end
  end

  def set_visibility
    if current_user && current_user.linked?
      @work_orders = current_user.transport_company.work_orders
    elsif current_admin
      @work_orders = WorkOrder.all
    end
  end

end
