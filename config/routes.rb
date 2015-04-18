Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  root 'welcome#index'

  resources :events, only: [:create, :update]

  namespace :admin do
    get '/' => 'dashboard#index', as: :dashboard

    resources :projects, except: [:show, :new, :update] do
      collection do
        patch :add_user
        patch :remove_user
      end
    end

    resources :users, except: [:new, :create]
  end
end
