WashINSA::Application.routes.draw do
  root :to => 'home#index'
  devise_for :user,
             path: '',
             :path_names => {:sign_in=>'login',:sign_out=>'logout',:sign_up=>'register'},
             :controllers => {
                 :registrations => 'registrations',
                 :omniauth_callbacks => "user/omniauth_callbacks"
             }
  resources :users
  resources :booking do
    get 'ask' => 'booking#ask_for'
  end
end