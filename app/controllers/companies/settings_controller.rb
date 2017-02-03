module Companies
  class SettingsController < BaseController
    before_action :manage_company

    def show
    end

    def update
      current_company.update(company_params)
      respond_with current_company, action: :show, location: root_path
    end

    private

    def company_params
      params.require(:company).permit(:title)
    end

    def manage_company
      authorize current_company, :manage?
    end
  end
end
