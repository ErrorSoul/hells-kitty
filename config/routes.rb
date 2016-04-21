Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'authentication/sessions' }

  namespace :admin do
    resource  :dashboard, only: :show
    resources :categories
  end

  namespace :api do
    namespace :v1 do
      resources :categories
    end
  end
end
