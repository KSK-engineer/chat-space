Rails.application.routes.draw do
  devise_for :users
  root "groups#index"
  resource :users, only: [:edit, :update, :destroy]
  resource :groups, only: [:index, :new, :create, :edit, :update]
  
end
