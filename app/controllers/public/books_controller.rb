class Public::BooksController < ApplicationController

  def index
    books_result = nil
    if params[:keyword].present?
      books_result = RakutenWebService::Books::Book.search(title: params[:keyword])
    else
      books_result = RakutenWebService::Books::Book.search(title: "ruby")
    end
      @books = Kaminari.paginate_array(books_result.to_a).page(params[:page]).per(5)
  end
  
  def show
    @book = RakutenWebService::Books::Book.search(isbn: params[:isbn]).first
    @tags = Tag.includes(:book_tags).where("book_tags.book_id": (Book.find_by(isbn: params[:isbn])&.id || 0))
    #@books = Kaminari.paginate_array(books_result.to_a).page(params[:page]).per(5)
  end
  
  def new
     @tag = Tag.new
  end
  
  def create
    @book = Book.find_or_initialize_by(isbn: book_params[:isbn])
    @book.assign_attributes(book_params)
    if @book.save
       flash[:notice] = "タグ付けしました"
       redirect_to book_path(@book.isbn)
    else
       render "public/books/show"
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "タグ付けしました"
       redirect_to book_path(@book.isbn)
    else
       render "public/books/show"
    end
  end
  
  private 

  def book_params
     params.require(:book).permit(:isbn, :tags_to_s)
  end
end
