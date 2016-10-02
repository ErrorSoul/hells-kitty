Rails.application.routes.draw do
  root 'mains#index'
  devise_for :admins, controllers: { sessions: 'authentication/sessions' }
  get 'list' => 'mains#list', as: 'list'
  get 'cart' => 'mains#cart', as: 'cart'

  namespace :admin do
    resource  :dashboard, only: :show
    resources :categories
    resources :products do
      post :search, on: :collection
    end
    resources :sizes
    resources :colors
    resources :looks
  end

  namespace :api do
    namespace :v1 do
      resources :categories
    end
  end
end
