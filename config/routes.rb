Rails.application.routes.draw do
  resources :stocks
  resources :teams
  resources :users
  resources :trans
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
