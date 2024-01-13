Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'comics'                  => "comics#index",     as: :comics
  get 'comics/tagged/:tag'      => "comics#tagged",    as: :tagged
  get 'comics/:year'            => "comics#for_year",  as: :comics_for_year
  get 'comics/:year/:month'     => "comics#for_month", as: :comics_for_month
  get "comic/:year/:month/:day" => "comics#show",      as: :comic
  post "comic/:id/comment"      => "comics#comment",   as: :comic_comments

  resources :books, only: [:index, :show]

  get "user" => "users#show"

  namespace :manage do
    root "comics#index"

    get 'comics/tagged/:tag'         => "comics#tagged",       as: :tagged
    get 'comics/year/:year'          => "comics#index_year",   as: :comics_for_year
    get 'comics/month/:year/:month'  => "comics#index_month",  as: :comics_for_month
    get "comic/:year/:month/:day"    => "comics#show_by_date", as: :comic_show_by_date
    patch "comic/:id/publish"        => "comics#publish",      as: :publish_comic
    resources :comics
    resources :books
  end

  # Defines the root path route ("/")
  root "comics#index"
end
