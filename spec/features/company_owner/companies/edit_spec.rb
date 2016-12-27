require "rails_helper"

feature "Edit Self Company" do
  let!(:company) { create(:company, :with_owner) }
  let(:current_user) { company.owner }

  let(:new_company_title) { "Super Company" }
  let(:success_update_notice_text) { "Company was successfully updated." }

  background do
    login_as current_user
  end

  scenario "Owner update company" do
    switch_to_subdomain(company.subdomain)

    visit settings_path

    within ".edit_company" do
      fill_in :company_title, with: new_company_title

      click_on "Update Company"
    end

    expect(page).to have_content(success_update_notice_text)
  end
end
