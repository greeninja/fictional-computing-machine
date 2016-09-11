Rails.application.routes.draw do

  get 'overview/index'

  root :to => "overview#index"

  resources :agents
  resources :teams
  resources :settings
  resources :tick_types
  resources :rat_types
  resources :users
  resources :notification
  resources :rats
  resources :ticks
  resources :broadcasts
  resources :qa_settings
  resources :qas
  resources :tickets

  resources :agents do
    resources :rats
  end

  resources :agents do
    resources :ticks
  end

  resources :settings do
    resources :tick_types
    resources :rat_types
    resources :qa_settings
  end

  resources :tickets do
    resources :qas
  end

  match ':controller(/:action(/:id(.:format)))', :via => [:get, :post]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
