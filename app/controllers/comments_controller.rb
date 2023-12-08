class CommentsController < ApplicationController

    before_action :authenticate_with_http_digest

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params)
        @comment.user = current_user

        if @comment.save
            redirect_to user_post_path(@post.author, @post), notice: "Bravo, you have created your comment!"
        else 
            redirect_to user_post_path(@post.author, @post), alert: 'Apologies try again!'
        end
        
    end

    private

    def comment_params
        params.require(:comment).permit(:text)
    end

end