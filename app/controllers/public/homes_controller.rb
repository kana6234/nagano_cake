class Public::HomesController < ApplicationController
  def top
    @items = Item.order('created_at DESC')
    @item3 = @items.first(4)
  end

  def about
  end
end
