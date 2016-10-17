Rails.application.routes.draw do
  root to: 'visitors#index'

  ActiveAdmin.routes(self)

  get '/be-a-host', to: 'visitors#be_a_host'
  get '/how-it-works', to: 'visitors#how_it_works'
  get '/private-events', to: 'visitors#private_events'
  get '/explore', to: 'events#index'
  get '/packages', to: 'packages#index'
  get '/contact-us', to: 'visitors#contact_us'
  get '/about-us', to: 'visitors#about_us'
  get '/in-the-news', to: 'visitors#in_the_news'
  get '/faq', to: 'visitors#faq'
  get '/account', to: 'visitors#account'
  post '/waitlists/get_on_waitlist', to: 'waitlists#get_on_waitlist'

  resources :events, only: [:show]
  resources :packages, only: [:show]
  resources :inquiries, only: [:create]

  resources :events do
    resources :payments, only: [:create, :new]
    get 'buy_tickets', on: :member
  end
  resources :payments, only: [:show]

  devise_for :users,
    controllers: {
      registrations: 'users/registrations'
    },
    path_names: { sign_in: 'login', sign_out: "logout" }
end
