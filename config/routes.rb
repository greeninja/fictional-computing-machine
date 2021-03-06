Rails.application.routes.draw do

  get 'overview/index'

  root :to => "overview#index"

  get 'agents/manage_agents' => 'agents#manage_agents', :as => 'manage_agents'
  resources :agents
  get 'manage_teams' => 'teams#manage_teams', :as => 'manage_teams'
  resources :teams
  resources :settings
  resources :tick_types
  resources :cross_types
  resources :users
  resources :notification
  resources :crosses
  resources :ticks
  resources :broadcasts
  resources :qa_settings
  resources :qa_general_settings
  get 'qas/:id/show_qa' => 'qas#show_qa', :as => 'show_qa'
  get 'qas/:id/edit_individual' => 'qas#edit_individual', :as => 'edit_individual_qas'
  get 'qas/teams' => 'qas#all_teams', :as => 'teams_qa'
  get 'qas/:id/team' => 'qas#team', :as => 'team_qas'
  put 'qas/:id/update_individual' => 'qas#update_individual', :as => 'update_individual_qas'
  resources :qas
  get 'tickets/feedback' => 'tickets#feedback', :as =>'tickets_feedback'
  post 'ticket/:id/req_feedback' => 'tickets#req_feedback', :as => 'ticket_request_feedback'
  post 'ticket/:id/clear_feedback' => 'tickets#clear_feedback', :as => 'ticket_clear_feedback'
  resources :tickets

  resources :agents do
    resources :crosses
  end

  resources :agents do
    resources :ticks
  end

  resources :settings do
    resources :tick_types
    resources :cross_types
    resources :qa_settings
    resources :qa_general_settings
  end

  resources :tickets do
    resources :qas
  end

  match ':controller(/:action(/:id(.:format)))', :via => [:get, :post]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
