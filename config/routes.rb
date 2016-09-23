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
  resources :qa_general_settings
  get 'qas/:id/edit_individual' => 'qas#edit_individual', :as => 'edit_individual_qas'
  get 'qas/teams' => 'qas#all_teams', :as => 'teams_qa'
  get 'qas/:id/team' => 'qas#team', :as => 'team_qas'
  put 'qas/:id/update_individual' => 'qas#update_individual', :as => 'update_individual_qas'
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
    resources :qa_general_settings
  end

  resources :tickets do
    resources :qas
  end

  match ':controller(/:action(/:id(.:format)))', :via => [:get, :post]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
