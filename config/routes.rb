Rails.application.routes.draw do
  root 'pages#home'

  resources :performance_snapshots
  resources :targets
end
