module CompanyAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_company!
    helper_method :current_company
  end

  private

  def current_company
    @current_company ||= Company.find_by(subdomain: request.subdomain)
  end

  def authenticate_company!
    current_company || respond_with_error
  end

  def respond_with_error
    if request.format.symbol == :json
      render json: { error: "Company unauthorized!" }, status: :unauthorized
    else
      redirect_to root_url(subdomain: nil)
    end
  end
end
