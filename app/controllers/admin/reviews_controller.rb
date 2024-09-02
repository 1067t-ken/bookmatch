class Admin::ReviewsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    @reviews = Review.all
    @reviews = @reviews.where('content LIKE ?', "%#{params[:keyword]}%") if params[:keyword].present?
  end
  
  def destroy
    @review = Review.find_by_id(params[:id])
    @review.destroy if @review
    flash[:notice] = "削除しました。"
    redirect_to admin_reviews_path
  end
end
