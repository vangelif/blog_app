class CommentsController < ApplicationController
  before_action :authenticate_with_http_digest
  before_action :authenticate_user!
  before_action :set_post, only: %i[new create]

  # localhost:3000/users/1/posts/1/comments/new
  def new
    @comment = Comment.new
  end

  # localhost:3000/users/1/posts/1/comments/new when you click create comment
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to user_post_path(@post.author, @post), notice: '📌 Bravo, you have created your comment!🎊'
    else
      flash[:alert] = 'Apologies try again!'
      redirect_to user_post_path(@post.author, @post)
    end
  end

  # localhost:3000/users/1/posts/1/ when you click remove comment
  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    # redirects us to localhost:3000/users/1/posts/
    redirect_to user_post_path(@comment.post.author, @comment.post), notice: '✂️🗃️ Comment was successfully deleted.'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
