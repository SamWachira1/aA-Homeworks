Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :cats do 
    resources :toys, only: [:index,  :new]
  end

  resources :toys, only: [:create, :show, :edit, :update, :destroy]
  root to: redirect('/cats')
end


  # resources :toys 

  # gets '/cats' to: 'cats#index', as: 'cats'
  # post '/cats', to: 'cats#create'
  # get '/cats/new', to: 'cats#new', as: 'cats'
  # get '/cats/:id/edit', to: 'cats#edit', as: 'edit_cat'
  # get '/cats/:id', to: 'cats#show', as: 'cat'
  # patch '/cats/:id', to: 'cats#update'
  # put '/cats/:id', to: 'cats#update'
  # delete '/cats/:id', to: 'cats#destroy'

