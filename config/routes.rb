Rails.application.routes.draw do
  root 'welcome#index'
  get "/log-in" => "sessions#new"
  post "/log-in" => "sessions#create"
  get "/log-out" => "sessions#destroy", as: :log_out
  resources :events
  resources :users
  resources :contacts
  resources :messages

end
