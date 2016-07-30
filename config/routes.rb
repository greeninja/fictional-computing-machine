Rails.application.routes.draw do

  root :to => "users#index"
  # ideally:
  # root :to => welcome#index
  # once built

  resources :users
  resources :teams
  resources :settings

  resources :users do
    resources :rats
  end

  resources :users do
    resources :ticks
  end

  resources :settings do
    resources :tick_types
    resources :rat_types
  end

  match ':controller(/:action(/:id(.:format)))', :via => [:get, :post]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
