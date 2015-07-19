Rails.application.routes.draw do
  root 'welcome#index'
  get "/log-in" => "sessions#new"
  post "/log-in" => "sessions#create"
  get "/log-out" => "sessions#destroy", as: :log_out
  resources :events
  resources :users, :only => [:index, :new, :create]
  resources :contacts, :only => [:index, :new, :create, :edit, :update, :destroy]
  resources :messages, :only => [:index, :new, :create, :destroy]

end
