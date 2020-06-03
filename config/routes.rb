Rails.application.routes.draw do
  root to: 'pages#home'

  resources :philanthropic_initiatives
  resources :beneficiaries
  resources :businesses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
