class ArtworksController < ApplicationController

    def index 
        user = params[:user_id]
        if user
            render json: Artwork.artworks_for_user_id(user)
        else
            render user.errors.full_messages, status: :unprocessable_entity
        end
    end


    def create
        artwork = Artwork.new(artwork_params)
        if artwork.saved
            render json: artwork
        else 
            render json: artwork.errors.full_messages, status: :unprocessable_entity 
        end
    end

    def destroy
        render json: Artwork.find(params[:id]).destroy
    end

    def show 
        render json: Artwork.find(params[:id])
    end

    def update
        artwork = Artwork.find(params[:id])

        if artwork.update(artwork_params)
            render json: artwork
        else  
            render json: artwork.errros.full_messages, status: :unprocessable_entity
        end

    end

    private
    def artwork_params
        params.require(:artworks).permit(:title, :image_url, :artist_id)
    end


end
