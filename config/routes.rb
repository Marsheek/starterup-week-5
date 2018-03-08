Rails.application.routes.draw do
  resources :enquiries
  devise_for :users
  root 'pages#home'

  get 'contact', to: 'pages#contact'

  get 'about', to: 'pages#about'

  get 'privacy', to: 'pages#privacy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
