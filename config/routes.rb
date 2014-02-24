Kairos::Application.routes.draw do

  # Static Pages
  get '/about', to: 'statics#about', as: 'about'
  get '/fellows', to: 'statics#fellows', as: 'fellows'
  get '/contact', to: 'statics#contact', as: 'contact'

  resources :projects do
    resources :images
    resources :comments
  end

  resources :articles do
    resources :comments
  end

  devise_for :users
  devise_scope :user do
    authenticated :user do
      root to: 'statics#about'
    end
    unauthenticated :user do
      root to: 'statics#about'
    end
    root to: 'statics#about'
  end
  resources :users, only: [:show]

  resources :events, only: [:new, :create, :show]
  resources :project_event_registrations, only: [:create]
  resources :user_event_registrations, only: [:create]
  resources :votes, only: [:create, :destroy]

end
