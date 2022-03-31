Rails.application.routes.draw do
  devise_for :users do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  root to: 'cocktails#index'
  resources :cocktails do
    resources :ingredients, only: %i[new create]
    resources :doses, only: %i[new create]
    resources :reviews, only: %i[new create]
    resources :favorites, only: %i[create destroy] do
      get 'favorites', to: 'favorites#create'
      delete 'favorites', to: 'favorites#destroy'
    end
  end

  resources :doses, only: :destroy
  resources :ingredients, only: %i[edit update destroy]
  resources :reviews, only: :destroy

  get 'profile', to: 'users#profile', as: 'profile'
  get 'explore', to: 'cocktails#explore', as: 'explore'
  get 'mypage', to: 'cocktails#mypage', as: 'mypage'
  get 'index', to: 'ingredients#index', as: 'ingredient_index'
  get 'new', to: 'ingredients#new', as: 'ingredient_new'
end
