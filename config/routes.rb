Kairos::Application.routes.draw do


  # Static Pages
  get '/about', to: 'statics#about', as: 'about'
  get '/fellows', to: 'statics#fellows', as: 'fellows'
  get '/contact', to: 'statics#contact', as: 'contact'
  post '/contact_us', to: 'statics#contact_us'

  root to: 'statics#about'

  resources :projects, except: [:destroy] do
    resources :images
    resources :comments
  end

  resources :articles, except: [:destroy] do
    resources :comments
  end

  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :users, only: [:show, :edit, :update]
  get '/dashboard', to: 'users#dashboard', as: :user_root

  resources :events, except: [:destroy] do
    resources :comments
  end

  resources :project_event_registrations, only: [:create, :destroy]
  resources :user_event_registrations, only: [:create, :destroy]
  resources :votes, only: [:create, :destroy]

  resources :user_projects, only: [:create, :destroy]

end
