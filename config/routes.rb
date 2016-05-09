Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'authentication/sessions' }

  root 'mains#index'

  namespace :admin do
    resource  :dashboard, only: :show
    resources :categories
    resources :products
  end

  namespace :api do
    namespace :v1 do
      resources :categories
    end
  end
end
