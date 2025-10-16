Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :users
  authenticated :user do
    root 'profiles#my_profile', as: :authenticated_root
  end

  root 'home#index'

  resources :profiles, only: [:show, :edit]
  resources :users, only: [:edit, :update]

  get 'my_profile', to: 'profiles#my_profile'

  resources :scripts, except: [:index] do
    resources :comments, only: [:create, :destroy]
    resources :spents, only: [:create]
    resources :items, only: [:create, :update, :destroy]
    member do
      get :news
    end
  end

  resources :checklists, except: [:index] do
    resources :items, only: [:create, :update, :destroy]
  end

  # Rotas destinadas ao ambiente de testes
  if Rails.env.test?
    # Rotas necessárias para a história de usuário: Comprar passagens
    get '/mock/latam', to: 'mocks#latam'
    get '/mock/gol', to: 'mocks#gol'
    get '/mock/azul', to: 'mocks#azul'
    get '/mock/erro', to: 'mocks#erro'
  end

  # Rota de desenvolvimento para auto-login rápido (APENAS em development)
  if Rails.env.development?
    get '/dev_login', to: 'dev#login'
  end

  get '/news', to: 'news#index'
end