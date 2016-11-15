require "rails_helper"

feature "Companies Index" do
  let!(:companies) { create_list(:company, 2, :with_owner) }
  let(:company_selector) { ".company-item" }

  scenario "Visitor see companies list" do
    visit root_path

    expect(all(company_selector).size).to eq(companies.count)
    companies.each(&method(:expect_to_have_company_data))
  end

  def expect_to_have_company_data(company)
    within ".company-item[data-id='#{company.id}']" do
      expect(page).to have_content(company.title)
      expect(page).to have_content(I18n.l(company.created_at, format: :us_date))
      expect(page).to have_content(company.owner.full_name)
    end
  end
end
