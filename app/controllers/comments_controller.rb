class CommentsController < ApplicationController
  before_action :authenticate_with_http_digest
  before_action :set_post, only: %i[new create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to user_post_path(@post.author, @post), notice: '🎊 Bravo, you have created your comment!'
    else
      flash[:alert] = 'Apologies try again!'
      redirect_to user_post_path(@post.author, @post)
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
