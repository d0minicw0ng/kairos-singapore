Kairos::Application.routes.draw do


  # Static Pages
  get '/about', to: 'statics#about', as: 'about'
  get '/fellows', to: 'statics#fellows', as: 'fellows'
  get '/contact', to: 'statics#contact', as: 'contact'
  post '/contact_us', to: 'statics#contact_us'

  root to: 'statics#about'

  resources :projects do
    resources :images
    resources :comments
  end

  resources :articles do
    resources :comments
  end

  devise_for :users
#   devise_scope :user do
#     authenticated :user do
#       root to: 'statics#about'
#     end
#     unauthenticated :user do
#       root to: 'statics#about'
#     end
#   end
  resources :users, only: [:show]
  get '/dashboard', to: 'users#dashboard'

  resources :events, only: [:new, :create, :show] do
    resources :comments
  end

  resources :project_event_registrations, only: [:create, :destroy]
  resources :user_event_registrations, only: [:create, :destroy]
  resources :votes, only: [:create, :destroy]

  resources :user_projects, only: [:create, :destroy]

end
