Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  post "/posts", to: "posts#create"
  get "/users/:user_id/posts", to: "posts#user_posts"
  post "/posts/:post_id/reviews", to: "reviews#create"
  get "/posts/top", to: "posts#top_posts"


end
