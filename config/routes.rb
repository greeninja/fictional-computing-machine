Rails.application.routes.draw do
 
  resources :rats
  resources :users
  
  match ':controller(/:action(/:id(.:format)))', :via => [:get, :post]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
