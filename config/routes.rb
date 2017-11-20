Rails.application.routes.draw do
  namespace :admin do
    root 'welcome#index'
    resources :roasts
    resources :batches, except: [:show, :index]
  end

  root 'welcome#index'
  resources :votes, only: :create
end
