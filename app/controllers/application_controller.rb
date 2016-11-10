class ApplicationController < ActionController::Base
  include Authentication
  include Authorization

  protect_from_forgery with: :exception

  responders :flash
  respond_to :html

  def after_sign_in_path_for(resource)
    root_url(resource.subdomain)
  end

  def signed_in_root_path(resource)
    root_url(resource.subdomain)
  end
end
