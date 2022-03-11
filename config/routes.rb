Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'cocktails#index'

  resources :cocktails do
    resources :ingredients, only: %i[create]
    resources :doses, only: %i[create]
    resources :reviews, only: %i[new create edit update]
    resources :favorites, only: [:create]
    delete 'favorites', to: 'favorites#destroy'
  end

  resources :cocktails, only: :destroy
  resources :doses, only: :destroy
  resources :reviews, only: :destroy

  get '/users/:id', to: 'users#show', as: 'users'
  get 'explore', to: 'cocktails#explore', as: 'explore'
  get 'mypage', to: 'pages#mypage', as: 'mypage'
end
