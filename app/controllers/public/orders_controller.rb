class Public::OrdersController < Public::BaseController
  before_action :have_cart_item, only: [:new, :create, :comfirm]
  before_action :is_matching_login_user, only: [:show]
  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
  end

  def index
    @orders = current_customer.orders.page(params[:page])
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.total_payment = total.round + @order.postage
    cart_items = current_customer.cart_items.all
    if @order.save
      cart_items.each do |cart|
        order_item = OrderItem.new
        order_item.item_id = cart.item_id
        order_item.order_id = @order.id
        order_item.price = cart.item.price
        order_item.amount = cart.amount
        order_item.save
      end
      cart_items.destroy_all
      redirect_to orders_complete_path
    else
      @order = Order.new(order_params)
      @customer = Customer.find(current_customer.id)
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all
    @total = @order_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def comfirm
    @cart_items = current_customer.cart_items
    total
    @order = Order.new(order_params)
    if params[:order][:select_address].to_i == 1
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address].to_i == 2
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address].to_i == 3 && !@order.postal_code.empty? && !@order.address.empty? && !@order.name.empty?
    else
      @order = Order.new
      @customer = Customer.find(current_customer.id)
      render :new
    end
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :postage)
  end

  def have_cart_item
    return if current_customer.cart_items.exists?
      redirect_to cart_items_path
  end

  def is_matching_login_user
    order = Order.find_by(id: params[:id])
    if current_customer.id != order.customer_id
      redirect_to orders_path
    end
  end
end
