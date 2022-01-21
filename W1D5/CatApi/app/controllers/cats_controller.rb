class CatsController < ApplicationController
    def index
        @cat = Cat.all 
        render :index
    end

    def show
        @cat = Cat.find(params[:id])
        render :show 
    end

    def create
        @cat = Cat.new(cat_params)
        if @cat.save
            redirect_to cat_url(@cat)  # == /cats/...
        else
            render :new
            # render json: @cat.errors.full_messages, status: :unprocessable_entity
        end
        
    end

    # 1. GET /cats/new to fetch a form 
    # 2. User fills out form, clicks submit
    # 3. POST /cats the data in the form 
    # 4. Create action is invoked, cat is created 
    # 5. Send client a rediret to /cats/#{id}
    # 6. Client makes a get request for /cats/#{id}
    # 7. Show action for newly created cat is invoked

    def new
        #/cats/new
        #show a form to create a new object 
        @cat = Cat.new
        render :new 
    end


    def update
        @cat = Cat.find(params[:id])
        if @cat.update(cat_params)
            redirect_to cat_url(@cat)
        else
             render :edit 
        end  
    end

    def edit 
        # /cats/:id/edit 
        #show a form to edit an existing object 

        @cat = Cat.find(params[:id])
        render :edit 
    end


    def destroy
      cat = Cat.find(params[:id])
      cat.destroy

      redirect_to cats_url
    end

 
    private
    def cat_params
        params.require(:cat).permit(:name, :skill)
    end


    
end
