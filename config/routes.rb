Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations"
  }
  root 'home#top'
  get 'about', to: 'home#about', as: :about
  resources :posts, only: %i[index new create edit update destroy] do
    collection do
      get :log
    end
  end
end
