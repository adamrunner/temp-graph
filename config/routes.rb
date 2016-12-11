Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get ':controller(/:action(/:id))'
  
  get 'temp', to: 'temps#receive'
end
