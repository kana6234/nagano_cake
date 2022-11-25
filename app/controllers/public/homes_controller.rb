class Public::HomesController < Public::BaseController
  def top
    @items = Item.order('created_at DESC')
    @item4 = @items.first(4)
    @genres = Genre.all
  end

  def about
  end
end
