Rails.application.routes.draw do
  devise_for :users do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  root to: 'cocktails#index'
  resources :cocktails do
    resources :ingredients, only: %i[new create]
    resources :doses, only: %i[new create]
    resources :reviews, only: %i[new create]
    resources :favorites, only: %i[create destroy]
  end

  resources :doses, only: :destroy
  resources :ingredients, only: %i[edit update destroy]
  resources :reviews, only: :destroy
  # resources :favorites, only: %i[create destroy]

  get 'profile', to: 'users#profile', as: 'profile'
  get 'explore', to: 'cocktails#explore', as: 'explore'
  get 'mypage', to: 'cocktails#mypage', as: 'mypage'
  get 'index', to: 'ingredients#index', as: 'ingredient_index'
  get 'new', to: 'ingredients#new', as: 'ingredient_new'
  # get '/cocktails/:cocktail_id/favorites', to: 'favorites#create'
  # get '/favorites', to: 'favorites#destroy'
end
