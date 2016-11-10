module Companies
  class BaseController < ApplicationController
    expose(:current_company, -> { Company.find_by(subdomain: request.subdomain) })

    before_action :authenticate_company!

    layout "company"

    private

    def authenticate_company!
      current_company || respond_with_error
    end

    def respond_with_error
      if request.format.symbol === :json
        render json: { error: "Company unauthorized!" }, status: :unauthorized
      else
        redirect_to root_url(subdomain: nil)
      end
    end
  end
end
