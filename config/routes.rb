Rails.application.routes.draw do
   get "login" => "users#login_form"
   post "login" => "users#login"
  post "logout" => "users#logout"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
resources :users
end
