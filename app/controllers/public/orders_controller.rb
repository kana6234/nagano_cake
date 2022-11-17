class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
  end

  def index
  end

  def create
  end

  def show
  end

  def comfirm
    redirect_to orders_comfirm_path
  end

  def complete
  end
end
