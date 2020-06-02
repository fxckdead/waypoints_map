require 'sidekiq/web'

Rails.application.routes.draw do
  root 'home#index'

  mount Sidekiq::Web => '/sidekiq'

  get '/show', to: 'home#show_map'

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :gps, only: [:create]
    end
  end
end
