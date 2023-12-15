class PostsController < ApplicationController
  load_and_authorize_resource
  # before_action :authenticate_user!
  # before_action :authenticate_user!, only: %i[new create]

  # localhost:3000/users/1/posts
  def index
    @posts = Post.includes(:author).includes(:comments).where(author: params[:user_id]).order(created_at: :asc)
    # when building the show all posts button
    # @author = @posts.first.author
    @author = User.find(params[:user_id])
  end

  # localhost:3000/users/1/posts/1
  def show
    @post = Post.find(params[:id])
    @current_user = current_user
  end

  # localhost:3000/users/1/posts
  def new
    @post = Post.new
    @current_user = current_user
  end

  # localhost:3000/users/1/posts/new when you click create button
  def create
    @post = Post.new(post_params)
    @post.author = current_user
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.valid?
      if @post.save
        flash[:success] = 'Your post is successfully posted! Bravo 🎊'
        redirect_to user_posts_path(current_user)
      else
        flash.now[:error] = 'Error Occurred while saving the post. Apologies, try again!'
        render :new
      end
    else
      flash.now[:error] = 'Error Occurred due to validation issues. Apologies, try again!'
      render :new
    end
  end

  # localhost:3000/users/1/posts/21 when you click delete post button
  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @post.comments.destroy_all
    @post.likes.destroy_all
    @post.destroy
    redirect_to user_posts_path(@post.author_id), notice: 'Post was successfully deleted.'
  end

  private

  # help to create the post
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
