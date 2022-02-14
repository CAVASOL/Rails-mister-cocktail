Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'cocktails#index'

  resources :cocktails do
    resources :ingredients, only: %i[create]
    resources :doses, only: %i[create]
    resources :reviews, only: %i[new create edit update]
  end

  resources :cocktails, only: :destroy
  resources :doses, only: :destroy
  resources :reviews, only: :destroy

  get 'explore', to: 'cocktails#explore', as: 'explore'
end
