Rails.application.routes.draw do
  resources :ratings
  resources :vehicles
  resources :passengers
  resources :rides
  resources :drop_points
  resources :routes
  resources :locations
  resources :roles

  get '/app/rides', to: 'user_rides#index'
  get '/app/rides/:id', to: 'user_rides#show'
  post '/app/rides/search', to: 'user_rides#search'
  post '/app/rides', to: 'user_rides#create'

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
