Rails.application.routes.draw do
  resources :tweet_messages
  root to: redirect('/top')
  get 'top' => 'zaim_api#top'
  get 'callback' => 'zaim_api#callback'
  get 'login' => 'zaim_api#login'
  get 'money' => 'zaim_api#money'

  get 'auth/:provider/callback' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout

  # view routing errors
  match '*path' => 'application#render_404', via: :all
end
