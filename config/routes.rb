HuntApp::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'root#index'

  namespace :api do
    namespace :v1 do
      # TODO: unfuck
      resources :hunts, except: [:new, :edit] do
        resources :locations, only: [:create, :update, :destroy]
      end
      resources :properties, except: [:index, :new, :edit] do
        resource :location, only: [:create, :update, :destroy]
      end
      resources :users, only: [:show] do
        resources :locations, only: [:create, :update, :destroy]
      end
    end
  end
end
