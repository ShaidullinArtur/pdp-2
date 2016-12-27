require "rails_helper"

feature "Create Company Posts" do
  let!(:company) { create(:company, :with_owner) }

  let(:dropdown_menu_selector) { ".top-bar-right.menu" }

  scenario "Visitor can't create company post" do
    switch_to_subdomain(company.subdomain)

    visit root_path

    expect(page).not_to have_selector(dropdown_menu_selector, text: "Create post")
  end
end
