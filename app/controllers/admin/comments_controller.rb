class Admin::CommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    @comments = Comment.all
    @comments = @comments.where('content LIKE ?', "%#{params[:keyword]}%") if params[:keyword].present?
  end
  
  def destroy
    @comment = Comment.find_by_id(params[:id])
    @comment.destroy if @comment
    flash[:notice] = "削除しました。"
    redirect_to admin_comments_path
  end
end
