class Public::FavoritesController < ApplicationController
  def create
    isbn =  params[:book_id]
    @book = Book.find_or_create_by(isbn: isbn)
    current_user.favorites.find_or_create_by(book_id: @book.id)
    redirect_back(fallback_location: root_url)
  end

  def destroy
    isbn = params[:book_id]
    @book = Book.find_by(isbn: isbn)
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy if favorite
    redirect_back(fallback_location: root_url)
  end

end
