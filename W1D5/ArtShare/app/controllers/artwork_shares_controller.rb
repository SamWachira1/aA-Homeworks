class ArtworkSharesController < ApplicationController


    def create 
        # POST   /artwork_shares(.:format)   
        artwork_share = ArtworkShare.new(artwork_shares_params)
        if artwork_share.save
            render json: artwork_share
        else   
            render json: artwork_share.errors.full_messages, status: :unprocessable_entity 
        end
    end

    def destroy
        # DELETE /artwork_shares/:id(.:format) 
       render json: ArtworkShare.find(params[:id]).destroy
    end

    
    private
    def artwork_shares_params 
        params.require(:artwork_shares).permit(:artwork_id, :viewer_id)
    end


end
