Rails.application.routes.draw do
  namespace :admin do
    resources :roasts
    resources :batches, except: :show
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
