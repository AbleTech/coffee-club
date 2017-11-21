Rails.application.routes.draw do
  namespace :admin do
    root 'welcome#index'
    resources :roasts
    resources :batches, except: [:show, :index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
