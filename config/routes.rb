require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  root to: 'dashboards#show'

  resource :dashboard, only: :show
  resources :reviews, only: [] do
    post :upload, on: :collection
  end
end
