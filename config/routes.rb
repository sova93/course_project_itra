# Rails.application.routes.draw do
#   get 'persons/profile'

#
#   devise_for :users, :controllers => {
#       omniauth_callbacks: 'omniauth_callbacks',
#       sessions: 'custom_session'
#   }
#   # get 'home/index'
#
#   # # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#   root 'home#index'
#   # get 'persons/profile', as: 'user_root'
#
# end

Rails.application.routes.draw do

  # We need to define devise_for just omniauth_callbacks:uth_callbacks otherwise it does not work with scoped locales
  # see https://github.com/plataformatec/devise/issues/2813
  devise_for :users, skip: [:session, :password, :registration, :confirmation], :controllers => {
      omniauth_callbacks: 'omniauth_callbacks',
  }
  scope '(:locale)' do
    # We define here a route inside the locale thats just saves the current locale in the session
    get 'omniauth/:provider' => 'omniauth#localized', as: :localized_omniauth

    devise_for :users, skip: [:omniauth_callbacks], controllers: {
        # passwords: 'passwords',
        # registrations: 'registrations',
        sessions: 'custom_session'
    }
    get 'persons/profile', as: 'user_root'
    match 'persons/edit', via: :all

    get 'persons/change_theme/(:theme_name)', to: 'persons#change_theme'

    resource :instructions
    resource :steps

    # resources :persons
    # resources :blocks

    root 'home#index'
  end
end