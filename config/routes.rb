Rails.application.routes.draw do
  
  resources :settings
  root :to => "users#index"
  # ideally:
  # root :to => welcome#index
  # once built
   
  resources :users
  resources :teams

  resources :users do
    resources :rats
  end

  resources :users do
    resources :ticks
  end
  
  match ':controller(/:action(/:id(.:format)))', :via => [:get, :post]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
