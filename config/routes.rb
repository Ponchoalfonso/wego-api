Rails.application.routes.draw do
  resources :routes
  resources :locations
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'auth',
               sign_out: 'auth',
               registration: 'auth/register'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }
  # devise_for :users
  resources :roles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
