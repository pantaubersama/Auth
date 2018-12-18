Rails.application.routes.draw do
  use_doorkeeper
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount API::Init, at: "/"

  mount GrapeSwaggerRails::Engine, as: "doc", at: "/doc"
end
