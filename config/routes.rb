Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'cocktails#index'

  resources :cocktails do
    resources :ingredients, only: %i[new create]
    resources :doses, only: %i[new create]
    resources :reviews, only: %i[new create]
    resources :favorites, only: [:create]
    delete 'favorites', to: 'favorites#destroy'
  end

  resources :doses, only: :destroy
  resources :ingredients, only: %i[edit update destroy]
  resources :reviews, only: :destroy

  get '/users/:id', to: 'users#show', as: 'users'
  get 'profile', to: 'users#profile', as: 'profile'
  get 'explore', to: 'cocktails#explore', as: 'explore'
  get 'mypage', to: 'cocktails#mypage', as: 'mypage'
  get 'index', to: 'ingredients#index', as: 'ingredient_index'
  get 'new', to: 'ingredients#new', as: 'ingredient_new'
end
