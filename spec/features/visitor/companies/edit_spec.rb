require "rails_helper"

feature "Edit Company" do
  let!(:company) { create(:company, :with_owner) }
  let(:access_denied_notice_text) { "You do not have access to the requested action!" }

  scenario "Visitor edit company" do
    switch_to_subdomain(company.subdomain)

    visit settings_path

    expect(page).to have_content(access_denied_notice_text)
  end
end
