Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root 'home#top'
  get 'about', to: 'home#about', as: :about
  resources :posts, only: %i[index]
end
