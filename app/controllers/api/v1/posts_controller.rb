class Api::V1::PostsController < ApplicationController
  # skip_before_action :authenticate_user!
  def index
    @author = User.find(params[:user_id])
    @posts = @author.posts
    render json: @posts, include: %i[comments likes]
  end

  def show
    @post = Post.find(params[:id])
    @current_user = current_user
    render json: @post
  end
end
