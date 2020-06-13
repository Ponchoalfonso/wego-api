Rails.application.routes.draw do
  root to: 'application#index'
  get 'app', to: 'application#index'

  resources :ratings
  resources :vehicles
  resources :passengers
  resources :rides
  resources :drop_points
  resources :routes
  resources :locations
  resources :roles

  get '/app/profile', to: 'profiles#show'
  put 'app/profile', to: 'profiles#update'
  patch 'app/profile', to: 'profiles#update'

  get '/app/profile/routes', to: 'profiles#routes'

  get '/app/profile/address', to: 'user_addresses#show'
  post '/app/profile/address', to: 'user_addresses#create'
  put '/app/profile/address', to: 'user_addresses#update'
  patch '/app/profile/address', to: 'user_addresses#update'

  get '/app/rides', to: 'user_rides#index'
  get '/app/rides/:id', to: 'user_rides#show'
  post '/app/rides/search', to: 'user_rides#search'
  post '/app/rides', to: 'user_rides#create'
  post '/app/rides/:id/reserve', to: 'user_rides#reserve'
  post '/app/rides/:id/rate', to: 'user_rides#rate'

  get '/app/vehicles', to: 'user_vehicles#show'
  post '/app/vehicles', to: 'user_vehicles#create'
  put '/app/vehicles', to: 'user_vehicles#update'
  patch '/app/vehicles', to: 'user_vehicles#update'

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
