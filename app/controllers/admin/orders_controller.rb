class Admin::OrdersController < Admin::BaseController
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all
    @total = @order_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def update
    @order = Order.find(params[:id])
    if params[:order][:status] == "confirmation_payment"
      @order.update(order_params)
      order_items = @order.order_items
      order_items.update(making_status: "awaiting_production")
      redirect_to admin_order_path(@order.id)
    elsif @order.update(order_params)
      redirect_to admin_order_path(@order.id)
    else
      @order_items = @order.order_items.all
      @total = @order_items.inject(0) { |sum, item| sum + item.subtotal }
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end