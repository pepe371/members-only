class PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts = @posts.where(user_id: params[:user_id]) if params[:user_id]
    @posts = @posts.order(:updated_at).reverse
  end

  def new
    redirect_to new_user_session_path unless user_signed_in?
    @post = Post.new
  end

  def create
    Post.create(
      user: current_user,
      body: params[:post][:description]
    ) unless params[:post][:description].blank?
    redirect_to user_posts_path current_user
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    @post.update!(body: params[:post][:body]) unless params[:post][:body].blank?
    redirect_to user_posts_path current_user
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to user_posts_path current_user
  end
end
