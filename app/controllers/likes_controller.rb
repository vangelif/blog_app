class LikesController < ApplicationController
  before_action :authenticate_with_http_digest

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user: current_user)

    if @like.save
      redirect_to user_post_path(@post.author, @post), notice: 'Liked This One!'
    else
      redirect_to user_post_path(@post.author, @post), alert: 'Something occured'
    end
  end
end
