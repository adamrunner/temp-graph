require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get ':controller(/:action(/:id))'
  get '/', to: 'temps#index'
  get 'temp', to: 'temps#receive'
  post 'request_update', to: 'temps#request_update'
  mount Sidekiq::Web => '/sidekiq'
end
