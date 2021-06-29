Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount_devise_token_auth_for 'User', at: '/api/v1/users', controllers: {
    registrations: 'api/v1/registrations',
    sessions: 'api/v1/sessions',
    confirmations: 'api/v1/confirmations',
    passwords: 'api/v1/passwords'
  }

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :targets, only: %i[create index destroy]
      resources :topics, only: :index
      devise_scope :user do
        resources :users, only: %i[show update] do
          controller :sessions do
            post :facebook, on: :collection
          end
        end
      end
      resources :about, only: %i[index]
      resources :contacts, only: %i[create]
      resources :conversations, only: :index do
        resources :messages, only: :index
      end

      mount ActionCable.server => '/cable'
    end
  end
end
