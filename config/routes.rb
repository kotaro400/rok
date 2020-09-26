Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
          sessions: 'users/sessions',
          registrations: 'users/registrations'
        }

  resources :commanders, only: [:index, :show] do
    collection do
      get :search
    end
  end

  resources :users_commanders, only: [:create, :update, :destroy]

  resources :teams

  get 'home/top'

  get "rank", to: "rank#form"

  post "rank", to: "rank#calc"

  root "home#top"
end
