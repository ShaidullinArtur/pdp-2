require "rails_helper"

feature "Company Users Index" do
  let!(:company) { create(:company, :with_owner) }

  scenario "Visitor not sees users page" do
    switch_to_subdomain(company.subdomain)

    visit root_path

    expect(page).not_to have_content("Users")
  end
end
