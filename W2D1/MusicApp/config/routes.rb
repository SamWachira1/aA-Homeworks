Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: redirect('/bands')
  resource :session, only: [:new, :create, :destroy]
  resource :users, only: [:show, :new, :create]

  resource :bands do   
    resource :albums, only: [:new]
  end

  resource :albums

end
