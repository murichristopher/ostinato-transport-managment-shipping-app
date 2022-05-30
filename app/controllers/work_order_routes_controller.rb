class WorkOrderRoutesController < ApplicationController

  def create
    @work_order_route = WorkOrderRoute.new(work_order_route_params)

    @work_order_route.work_order = WorkOrder.friendly.find(params[:work_order_route][:id])

    @work_order_route.work_order.carrier_vehicle_id = params[:carrier_vehicle][:id]

    if @work_order_route.work_order.status != "pendente" && @work_order_route.work_order.status != "recusada" && @work_order_route.work_order.status != "recebida"
      if current_user.transport_company == @work_order_route.work_order.transport_company
        if @work_order_route.save

          @status = params[:status]
            if @status == "em_transporte"
             @work_order_route.work_order.em_transporte!
            else
              @work_order_route.work_order.recebida!
            end

          redirect_to @work_order_route.work_order, notice:"Atualização de rota registrada com sucesso!"
        else
          @errors = @work_order_route.errors.full_messages
        end
      end
    end


  end

  def destroy
    @route = WorkOrderRoute.find(params[:id])

    @work_order = WorkOrder.friendly.find(params[:work_order])

    if current_user.transport_company == @work_order.transport_company
      return redirect_to @work_order, notice: "Atualização deletada com sucesso!" if @route.destroy
    end
  end

  private

  def work_order_route_params
    params.require(:work_order_route).permit(:title, :date, :last_location, :next_location)
  end


end

