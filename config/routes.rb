WashINSA::Application.routes.draw do
  ActiveAdmin.routes(self)
  root :to => 'home#index'
  devise_for :user,
             path: '',
             :path_names => {:sign_in=>'login',:sign_out=>'logout',:sign_up=>'register'},
             :controllers => {
                 :registrations => 'registrations',
                 :omniauth_callbacks => "user/omniauth_callbacks"
             }
  get 'logout' => 'home#logout'
  resources :users
  resources :booking do
    get 'ask' => 'booking#ask_for'
  end
  get 'bookings(/:year/:month/:day)' => 'booking#index', :as => :bookings_on
end