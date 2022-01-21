class ToysController < ApplicationController 
    
    def index
        # /cats/:cat_id/toys
        cat = Cat.find(params[:cat_id])
        render json: cat.toys
    end


    def show
        # /cats/:cat_id/toys/:id
        #/toys/:id  <<
        render json: Toy.find(params[:id])
    end

    def create
        # /cats/:cat_id/toys   
        # /toys 
        @toy = Toy.new(toy_parms_create)
        @cat = @toy.cat

        if @toy.save
            redirect_to cat_url(@cat)
        else 
            render :new
        end
    end

    def destroy
        render json: Toy.find(params[:id]).destroy
    end

    def update
     toy = Toy.find(params[:id])
         if toy.update(toy_params_update)
            render json: toy 
         else 
            render json: toy.erros.full_messages, status: :unprocessable_entity
         end
    end

     def new
        @cat = Cat.find(params[:cat_id])
        @toy = Toy.new
        render :new
     end
        

    private
    def toy_params_update
        params.require(:toy).permit(:name)
    end

    def toy_parms_create
        params.require(:toy).permit(:cat_id, :name, :ttype)
    end




end
