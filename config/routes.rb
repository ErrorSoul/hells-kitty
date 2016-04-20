Rails.application.routes.draw do
   devise_for :admins, controllers: { sessions: 'authentication/sessions' }
end
