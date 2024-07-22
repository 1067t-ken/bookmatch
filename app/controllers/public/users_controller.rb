class Public::UsersController < ApplicationController
    def index
     @users = User.all.page(params[:page]).per(5)
     @user = current_user
    end
    def show
     @user = current_user
     @post_images = @user.post_images
    end
    def edit
    end
end
