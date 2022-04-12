Rails.application.routes.draw do
  devise_for :users, skip: :all

  namespace :api do
    post 'login', to: 'users#login'
    get 'feed', to: 'scores#user_feed'
    resources :scores, only: %i[create destroy]
    resources :users, only: %i[show]
    resources :users do
      resources :articles, only: %i[index show create]
    end
  end
end
