Rails.application.routes.draw do
  root "welcome#index"

  mount Genkan::Engine, at: "/"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
