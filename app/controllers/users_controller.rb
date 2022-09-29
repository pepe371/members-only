class UsersController < ApplicationController
  def show
    @posts = Post.where(user: params[:id])
    render 'posts/index'
  end
end
