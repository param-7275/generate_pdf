Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/show" ,to: "users#show", as:"show"

  get "/signup" ,to: "users#new_signup", as:"sign_up"
  post "/signup" ,to: "users#signup", as:"user_signup"
  get "/login" ,to: "users#new_login", as:"login"
  get "/about" ,to: "users_contact#about", as:"about"
  get "/news" ,to: "users_contact#news", as:"news"

  post "/login" ,to: "users#login", as:"user_login"
  get "/contact" ,to: "users_contact#new_contact", as:"contact"
  post "/contact" ,to: "users_contact#contact", as:"user_contact"
  match '/logout(/:id)', to: "users#destroy", as: "user_logout", via: [:get, :delete]
  
  get "/new" ,to: "questions#new", as:"new_question"
  post "/create" ,to: "questions#create", as:"create_question"
  get "/index" ,to: "questions#index", as:"show_question"
  delete "/destroy/:id" , to: "questions#delete_question" , as: "delete_question"
  get "/generate_pdf" ,to: "questions#generate_pdf", as:"generate_pdf"

  
  resources :passwords, only: [:new, :create, :edit, :update]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "users#index"
end
