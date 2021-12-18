Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup' , to: 'users#new'
  
  resources :users, only: [:index, :show, :create , :edit, :update] do
    member do
      get :followings
      get :followers
    end
      collection do
      get :contributor_rank
    end
  end
  
  resources :recipes do
    collection do
      get :ranking
      get :fast
      get :cheep
      get :search
      get :all_recipes
    end
    
    member do
      get :materials
    end
  end
  
  post 'recipes/:id/materials' => 'recipes_foods#create'
  
  
  resources :foods, only: [:destroy]
  
  resources :recipes_foods, only: [:create]
  
  resources :relationships, only: [:create, :destroy]
  
  resources :favorites,only: [:create, :destroy]
end

