Rails.application.routes.draw do
  root to: redirect('/top')
  get 'top' => 'zaim_api#top'
  get 'callback' => 'zaim_api#callback'
  get 'login' => 'zaim_api#login'
  get 'money' => 'zaim_api#money'

  # view routing errors
  match '*path' => 'application#render_404', via: :all
end
