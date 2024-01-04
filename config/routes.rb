Rails.application.routes.draw do
  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'comics'                  => "comics#index",     as: :comics
  get 'comics/:year'            => "comics#for_year",  as: :comics_for_year
  get 'comics/:year/:month'     => "comics#for_month", as: :comics_for_month
  get "comic/:year/:month/:day" => "comics#show",      as: :comic

  #get "user" => "users#index"
  #get "user/:id" => "users#show"

  namespace :manage do
    root "comics#index"

    get 'comics'                        => "comics#index",        as: :comics
    post 'comics'                       => "comics#create"

    get 'comics/new'                    => "comics#new",          as: :new_comic
    get 'comics/:year'                  => "comics#index_year",   as: :comics_for_year
    get 'comics/:year/:month'           => "comics#index_month",  as: :comics_for_month

    get "comic/:year/:month/:day"       => "comics#show_by_date", as: :comic
    get "comic/:year/:month/:day/edit"  => "comics#edit",         as: :edit_comic

    patch "comic/:id"                   => "comics#update",       as: :update_comic
    patch "comic/:year/:month/:day/publish" => "comics#publish",  as: :publish_comic

    delete "comic/:year/:month/:day"    => "comics#destroy",      as: :delete_comic
  end

  # Defines the root path route ("/")
  root "comics#index"
end
