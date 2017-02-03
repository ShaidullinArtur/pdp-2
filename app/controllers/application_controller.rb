class ApplicationController < ActionController::Base
  include Authentication
  include Authorization

  protect_from_forgery with: :exception

  responders :flash
  respond_to :html

  def after_sign_in_path_for(resource)
    resource.is_a?(AdminUser) ? admin_root_path : root_url(resource.subdomain)
  end

  def signed_in_root_path(resource)
    root_url(resource.subdomain)
  end

  def serialize(resource, options = {})
    ActiveModelSerializers::SerializableResource.new(resource, options)
  end
end
