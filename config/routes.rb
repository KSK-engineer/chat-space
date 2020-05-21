Rails.application.routes.draw do
  devise_for :users
  root "messages#index"
  resource :users, only: [:edit, :update, :destroy, ]
  
end
