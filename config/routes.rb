Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  get "up" => "rails/health#show", as: :rails_health_check
  
  root "beaches#index"
  
  resources :beaches, only: [:index, :show] do
    member do
      post 'favorite', to: 'favorites#create'
      delete 'unfavorite', to: 'favorites#destroy'
    end
  end
  
  get 'favoritos', to: 'favorites#index', as: :favorites
end
