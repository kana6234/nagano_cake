class Admin::OrderItemsController < ApplicationController
  def update
    @order = Order.find(params[:id])
    if @order.order_items.update(order_item_params)
      redirect_to admin_order_path(@order.id)
    else
      @order_items = @order.order_items.all
      @total = @order_items.inject(0) { |sum, item| sum + item.subtotal }
      render "orders/show"
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:making_status)
  end
end
