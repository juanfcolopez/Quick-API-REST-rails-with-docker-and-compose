Rails.application.routes.draw do
  scope :api do
    resources :animals
    #get    'animals', to: animals#index
    #get    'animals', to: animals#show
    #post   'animals', to: animals#create
    #delete 'animals', to: animals#destroy
    #patch  'animals', to: animals#update
  end
end
