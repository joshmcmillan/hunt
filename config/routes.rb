HuntApp::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'root#index'

  namespace :api do
    namespace :v1 do
      resources :hunts, except: [:new, :edit]
      resources :properties, except: [:index, :new, :edit]
      resources :users, except: [:new, :edit]
    end
  end
end
