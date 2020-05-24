Rails.application.routes.draw do
  devise_for :users
  root "groups#index"
  resource :users, only: [:edit, :update, :destroy]
  resource :groups, only: [:new, :create, :edit, :update] do
    resource :messages, only: [:index, :create]
  end
end
