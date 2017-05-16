Rails.application.routes.draw do
  root 'posts#index'
  resources :posts do
    resources :likes, only: [:create, :destroy]
  end

  resources :items
  # get('/users/:id', {to:'users#show_posts'})
  resources :users, only:[:show, :new, :create, :update, :edit] do
    resources :followers, only:[:index]
    resources :followings, only:[:create, :destroy]
  end
  resources :sessions, only:[:new, :create] do
    delete :destroy, on: :collection
    #get rid of ":id" in the url
  end

  resources :categories, only: :index
  resources :genders, only: :index
end
