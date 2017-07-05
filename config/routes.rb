Genkan::Engine.routes.draw do
  get  "/login",                   to: "sessions#new"
  get  "/logout",                  to: "sessions#destroy"
  get  "/auth/:provider/callback", to: "sessions#create"
  post "/auth/:provider/callback", to: "sessions#create"
end
