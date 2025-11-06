Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  authenticated :user do
    root 'profiles#my_profile', as: :authenticated_root
  end

  root 'home#index'

  resources :profiles, only: [:show, :edit]
  resources :users, only: [:edit, :update]

  get 'my_profile', to: 'profiles#my_profile'

  resources :scripts, except: [:index] do
    resources :script_comments, only: [:create, :destroy], controller: 'scripts/comments'
    resources :script_spends, only: [:create, :destroy], controller: 'scripts/spends'
    resources :script_items, only: [:create, :update, :destroy], controller: 'scripts/items'
    resources :participants, only: [:create, :destroy], controller: 'scripts/participants'
    member do
      get :news
    end
  end

  resources :checklists, except: [:index] do
    resources :checklist_items, only: [:create, :update, :destroy], controller: 'checklists/items'
    resources :participants, only: [:create, :destroy], controller: 'checklists/participants'
  end

  # Rotas destinadas ao ambiente de testes
  if Rails.env.test?
    # Rotas necessárias para a história de usuário: Comprar passagens
    get '/mock/latam', to: 'mocks#latam'
    get '/mock/gol', to: 'mocks#gol'
    get '/mock/azul', to: 'mocks#azul'
    get '/mock/erro', to: 'mocks#erro'
  end

  # Rota de desenvolvimento para auto-login removida

  get '/news', to: 'news#index'
  
  # Página simples para montar URL do Google Maps (search)
  get 'maps/search', to: 'maps#search'
  post 'maps/search', to: 'maps#submit', as: :maps_search_submit
end