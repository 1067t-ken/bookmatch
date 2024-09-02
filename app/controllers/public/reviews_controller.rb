class Public::ReviewsController < ApplicationController

  def create
    @book = Book.find_or_create_by(isbn: params[:isbn])
    
    @review = current_user.reviews.find_or_initialize_by(book_id: @book.id)
    @review.assign_attributes(review_params)

    if @review.save
      redirect_to book_path(@book.isbn), notice: 'Review was successfully created.'
    else
      @local_book = @book
      @book = RakutenWebService::Books::Book.search(isbn: @local_book.isbn).first
      @tags = Tag.includes(:book_tags).where("book_tags.book_id": (Book.find_by(isbn: params[:isbn])&.id || 0))
      @average = @local_book&.reviews&.average(:star) || 0
      flash.now[:alert] = 'Failed to create review.'
      render 'public/books/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:star, :content)
  end
end

