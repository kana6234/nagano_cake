class Admin::HomesController < Admin::BaseController
  def top
    @orders = Order.page(params[:page])
  end
end
