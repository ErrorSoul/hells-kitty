Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'authentication/sessions' }

  namespace :admin do
    resource  :dashboard, only: :show
  end
end
