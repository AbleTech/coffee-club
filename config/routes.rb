Rails.application.routes.draw do
  namespace :admin do
    root 'welcome#index'
    resources :roasts
    resources :batches, except: [:show, :index]
  end

  root 'welcome#index'
  get '/admin' => 'admin#index', as: :admin_root
end
