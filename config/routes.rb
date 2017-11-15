Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

# DO I NEED THE ID
# expose as little as possible
  resources :polls do
    resources :propositions
    resources :votes, only: [:create]
    member do
      #get "share_poll", to: 'polls#share_poll'
      #get "show", to: 'polls#home'
      get "compare", to: 'polls#compare'
      get "start", to: 'polls#start'
      get "results", to: 'polls#results'
      get "start", to: 'polls#start'
      get "results", to: 'polls#results'
      get "add_propositions", to: 'polls#add_propositions'
    end
    resources :participants, only: [:index, :create, :destroy]
  end
  resource :profiles, only: [:show, :new, :create, :edit, :update]
end
