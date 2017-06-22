Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'posts#index'
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :bookmarks, only: [:create, :destroy]
  end


  resources :items
  resources :users, only:[:show, :new, :create, :update, :edit] do
    resources :followers, only:[:index]
    resources :followings, only:[:create, :destroy]
    resources :bookmarks, only: :index
  end
  resources :sessions, only:[:new, :create] do
    delete :destroy, on: :collection
    #get rid of ":id" in the url
  end

  resources :categories, only: :index
  resources :genders, only: :index
end
