Rails.application.routes.draw do
  post '/app/rides/search', to: 'user_rides#search'

  resources :vehicles
  resources :passengers
  resources :rides
  resources :drop_points
  resources :routes
  resources :locations
  resources :roles

  # devise_for :users
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
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
