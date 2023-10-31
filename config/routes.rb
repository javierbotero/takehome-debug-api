Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'
  resources :users, only: %i[index show]
  post 'users/register' => 'users#register'
  get 'users/:id/path' => 'users#path'
end
