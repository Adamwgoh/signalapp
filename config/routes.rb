Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  #root 'tweets#index'
  root to: "static_pages#index"

  scope :api do
    get 'tweets/index', to: 'tweets#index'
    get 'tweets/download', to: 'tweets#download.csv'
    get 'tweets/search', to: 'tweets#search'
    #get 'users/search', to: 'users#search'
    #get 'users/download', to: 'users#download.csv'
    #get 'users/:id', to: 'users#show', as: 'users'
  end

  scope :auth do
    get 'is_signed_in', to: 'auth#is_signed_in?'
  end
  
  get "*path" => "static_pages#index"
end
