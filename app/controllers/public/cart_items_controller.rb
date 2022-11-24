class Public::CartItemsController < Public::BaseController
  before_action :is_matching_login_user, only: [:update]
  def index
    @cart_items = current_customer.cart_items
    total
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    return if params[:cart_item][:is_active] == "false"
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      redirect_to cart_items_path
    elsif @cart_item.save
      redirect_to cart_items_path
    else
      redirect_to items_path
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      @cart_items = current_customer.cart_items
      total
      render :index
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

  def is_matching_login_user
    cart_item = CartItem.find_by(id: params[:id])
    if current_customer.id != cart_item.customer_id
      redirect_to cart_items_path
    end
  end
end
