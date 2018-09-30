Rails.application.routes.draw do
  resources :stocks
  resources :teams
  resources :users
  resources :trans
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'debit', to: 'we#debit'
  post 'credit', to: 'we#credit'
  post 'transfer', to: 'we#transfer'
  post 'trans_list', to: 'we#trans_list'

  root 'we#home'

end
