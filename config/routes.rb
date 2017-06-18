Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :admin_users

    root to: "users#index"
  end

  devise_for :users
  # ,  :controllers => {:registrations=> "registrations"}
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :messages, only: [:new, :create, :index, :show] do
    collection do 
      get :top_count
    end
  end
  root to: 'messages#index'
end
