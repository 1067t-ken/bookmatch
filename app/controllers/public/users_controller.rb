class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
   @users = User.all.page(params[:page]).per(5)
   @user = current_user
  end
    
  def show
    @user = User.find(params[:id])
    isbns = @user.books.pluck(:isbn)
    @books = []
    isbns.each do |isbn|
      result = RakutenWebService::Books::Book.search(isbn: isbn.to_i)
      @books << result.first
      @books = Kaminari.paginate_array(@books).page(params[:page]).per(5)
    end
  end
  
  def edit
  end
    
  def update
    if @user.update(user_params)
      flash[:notice] = "変更しました。"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "変更に失敗しました。"
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "退会しました。"
    redirect_to root_path
  end
  
  def favorites
    @user = User.find(params[:id])
    isbns = @user.favorite_books.pluck(:isbn)
    @books = []
    isbns.each do |isbn|
      result = RakutenWebService::Books::Book.search(isbn: isbn.to_i)
      @books << result.first
      @books = Kaminari.paginate_array(@books).page(params[:page]).per(5)
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page])
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page])
  end
  
  def guest_sign_in
    @user = User.find_or_initialize_by(email: "guest@test.com")
    @user.assign_attributes(password: SecureRandom.hex(8), name: "ゲストユーザー")
    if @user.save
      sign_in(@user)
    end
    redirect_to root_url
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end
  
  def correct_user
    @user = User.find_by_id(params[:id])
    redirect_to roote_url unless @user == current_user
  end
end
