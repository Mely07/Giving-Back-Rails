Rails.application.routes.draw do
  root to: 'pages#home'
  
  resources :philanthropic_initiatives
  resources :beneficiaries, only: [:index, :show, :update]
  resources :businesses
  

  resources :businesses, only: [:show, :index] do
    resources :philanthropic_initiatives, only: [:show, :index, :new, :edit]
  end

  resources :sessions

  get '/signin' => 'sessions#new'
  get 'auth/:provider/callback', to: 'sessions#googleAuth' #after successfully signing in thru Google path gets called
  get 'auth/failure', to: redirect('/')

  get '/logout' => 'sessions#destroy'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
