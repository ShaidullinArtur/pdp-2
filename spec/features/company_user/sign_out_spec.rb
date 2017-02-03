require "rails_helper"

feature "Sign Out" do
  include_context "company user signed in"

  scenario "User signs out" do
    switch_to_subdomain(company.subdomain)

    visit root_path

    click_link "Sign out"

    expect(page).to have_content("Sign in")
  end
end
