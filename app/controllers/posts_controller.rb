class PostsController < ApplicationController
  def index
    @posts = Post.includes(:author).includes(:comments).where(author: params[:user_id]).order(created_at: :asc)
    # when building the show all posts button
    @author = @posts.first.author
  end

  def show
    @post = Post.find(params[:id])
  end
end
