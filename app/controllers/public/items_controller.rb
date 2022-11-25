class Public::ItemsController < Public::BaseController
  def index
    @items = Item.all
    @item = Item.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
