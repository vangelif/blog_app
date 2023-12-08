class PostsController < ApplicationController
  def index
    @posts = Post.includes(:author).includes(:comments).where(author: params[:user_id]).order(created_at: :asc)
    # when building the show all posts button
    @author = @posts.first.author
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @current_user = current_user
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      flash[:success] = "Your post is successfully posted! Bravo 🎊"
      redirect_to user_posts_path(current_user)
    else
      flash.now[:error] = "Error Occured.. Apologies, try again!"
      render :new
    end
  end

  private
  
    def post_params
      params.require(:post).permit(:title, :text)
    end
end
