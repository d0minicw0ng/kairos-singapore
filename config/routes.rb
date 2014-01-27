Kairos::Application.routes.draw do
  devise_for :users
  devise_scope :user do 
    authenticated :user do
      root :to => 'devise/sessions#new'
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new'
    end
    root :to => 'devise/sessions#new'
  end

  resources :projects do
    resources :images
    resources :comments
  end

  resources :articles do
    resources :comments
  end
end
