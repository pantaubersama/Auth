Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :authorized_applications, :applications
  end
  
  mount API::Init, at: "/"
  mount API::InitDashboard, at: "/dashboard"

  mount GrapeSwaggerRails::Engine, as: "doc", at: "/doc"
end
