class CompaniesController < ApplicationController
  expose(:companies, -> { Company.includes(:owner).order(created_at: :desc) })
  expose(:company)

  def index
  end

  def new
    company.build_owner
  end

  def create
    company.owner.subdomain = company.subdomain
    if company.save
      redirect_to root_url(subdomain: company.subdomain)
    else
      render :new
    end
  end

  private

  def company_params
    params.require(:company).permit(
      :title, :subdomain,
      owner_attributes: %i(full_name email password password_confirmation)
    )
  end
end
