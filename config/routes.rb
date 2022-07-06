Rails.application.routes.draw do
  devise_for :users do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  root to: 'cocktails#index'
  resources :cocktails do
    resources :ingredients, only: %i[show new create]
    resources :doses, only: %i[new create]
    resources :reviews, only: %i[new create]
    resources :messages, only: %i[index create]
    resources :favorites, only: :create
    delete 'favorites', to: 'favorites#destroy'
  end

  resources :doses, only: :destroy
  resources :ingredients, only: %i[show edit update destroy]
  resources :reviews, only: :destroy

  get 'profile', to: 'users#profile', as: 'profile'
  get 'explore', to: 'cocktails#explore', as: 'explore'
  get 'mypage', to: 'cocktails#mypage', as: 'mypage'
  get 'index', to: 'ingredients#index', as: 'ingredient_index'
  get 'new', to: 'ingredients#new', as: 'ingredient_new'
  get 'inbox', to: 'users#inbox', as: 'inbox'
end
