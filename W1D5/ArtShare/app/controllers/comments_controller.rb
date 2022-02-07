class CommentsController < ApplicationController

    def index 
        case 
        when params[:user_id]
            comments = Comment.where(user_id: params[:user_id])
        when params[:artwork_id]
            comments = Comment.where(artwork_id: params[:artwork_id])
        else 
           comments = Comment.all 
        end
        render json: comments
    end

    def create
        comment = Comment.new(comments_params)
        if comment.save 
            render json: comment
        else 
            render json: comment.errors.full_messages, status: :unprocessable_entity 
        end
    end

    def destroy 
        render json: Commenet.find(params[:id]).destroy
    end

    private
    def comments_params
        params.require(:comment).permit(:body, :user_id, :artwork_id)
    end


end