class Api::V1::CommentsController < ApplicationController
    # app/controllers/api/v1/comments_controller.rb
    skip_before_action :verify_authenticity_token, only: %i[create]
  
  #  .../comments
    def index
      set_user
      set_post
      @comments = @post.comments
      render json: @comments, include: %i[user post]
    end
  
  #   ../comments/21
  
    def create
      @post = set_post
      @comment = @post.comments.new(comment_params)
      if @comment.save
        render json: @comment, status: :created
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def set_user
      @user = User.find(params[:user_id])
    end
  
    def comment_params
      # 
      params.require(:comment).permit(:user_id, :text)
    end
  end