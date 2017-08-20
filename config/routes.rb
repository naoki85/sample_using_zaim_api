Rails.application.routes.draw do
  resources :tweet_messages, only: %i[new create edit update destroy]
  root to: redirect('/top')
  get 'top' => 'pages#top'

  get 'callback' => 'zaim_api#callback'
  get 'login_to_zaim' => 'zaim_api#login'
  get 'zaim/money' => 'zaim_api#index'

  get 'auth/:provider/callback' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: :logout

  get 'user/edit' => 'users#edit', as: :edit_user
  patch 'user' => 'users#update', as: :user

  # view routing errors
  match '*path' => 'application#render_404', via: :all
end
