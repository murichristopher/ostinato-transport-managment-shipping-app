class WorkOrdersController < ApplicationController
  before_action :authenticate_user
  before_action :set_visibility


  def index
  end

  def show
    @work_order = WorkOrder.find(params[:id])
  end

  def new
    @work_order = WorkOrder.new
  end

  def create
    @work_order = WorkOrder.new(params[:work_order])
    if @work_order.save
      redirect_to @work_order, :notice => "Successfully created work order."
    else
      render :action => 'new'
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

  def work_order_params

  end

  private

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
