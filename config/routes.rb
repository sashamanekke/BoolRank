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
      get "share_poll", to: 'poll#share_poll'
      get "home", to: 'polls#home'
      get "compare", to: 'polls#compare'
      get "ask_rank", to: 'polls#ask_rank'
      get "rank", to: 'polls#rank'
      get "share_rank", to: 'polls#share_rank'
    end
    # collection do
    #   get 'top-3', to: 'polls#top_3'
    # end
    resources :participants, only: [:index, :show, :create, :update, :destroy]
  end
  resources :profiles, only: [:show, :new, :create, :edit]
end
