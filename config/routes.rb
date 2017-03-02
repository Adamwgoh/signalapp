Rails.application.routes.draw do
  root 'tweets#index'
  get 'tweets/index', to: 'tweets#index'
  get 'tweets/download', to: 'tweets#download.csv'
  get 'tweets/search', to: 'tweets#search'
  get 'users/search', to: 'users#search'
  get 'users/download', to: 'users#download.csv'
  get 'users/:id', to: 'users#show', as: 'users'
end
