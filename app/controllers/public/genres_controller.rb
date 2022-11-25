class Public::GenresController < ApplicationController
  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @item = @genre.items.page(params[:page]).per(8)
  end
end
