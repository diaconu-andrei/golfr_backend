Rails.application.routes.draw do
  devise_for :users, skip: :all

  namespace :api do
    post 'login', to: 'users#login'
    get 'feed', to: 'scores#user_feed'
    get 'users/:id/articles', to: 'articles#user_articles'
    post 'users/:id/articles', to: 'articles#create'
    get 'users/:id/articles/:post_id', to: 'articles#show'
    resources :scores, only: %i[create destroy]
    resources :users, only: %i[show]
  end
end
