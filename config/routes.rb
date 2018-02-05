Rails.application.routes.draw do

  root to: 'check#live'

  post 'friendship', to: 'friendship#create'
  get 'friendship', to: 'friendship#index'
  get 'friendship/common', to: 'friendship#common'

  post 'subscription', to: 'subscription#create'

  post 'blacklist', to: 'blacklist#create'

  get 'message/recipients', to: 'message#recipients'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
