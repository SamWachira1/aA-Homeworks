class UsersController < ApplicationController

    def index 
       if params[:query]
            user = User.where('username LIKE ?', "%#{params[:query]}%" )
       else 
            user = User.all 
       end
       render json: user 
    end

    def create
        user = User.new(user_params)
        if user.save
          render json: user
        else 
          render json: user.errors.full_messages, status: :unprocessable_entity 
        end
    end

    def destroy 
        render json: User.find(params[:id]).destroy
    end

    def show 
        render json: User.find(params[:id])
    end

    def update
        user = User.find(params[:id])
        if user.update(user_params)
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity 
        end
    end

    private 
    def user_params
        params.require(:user).permit(:username)
    end 

end





