require "rails_helper"

feature "New Company" do
  let(:new_company_attributes) do
    {
      title: "Super Company",
      subdomain: "my-super.subdomain",
      owner_full_name: "Chuck Norris",
      owner_email: "chuck_norris@mail.com",
      owner_password: "Super Company"
    }
  end

  scenario "Visitor create new company" do
    visit root_path

    click_on "New Company"

    within "#new_company" do
      fill_in :company_title, with: new_company_attributes[:title]
      fill_in :company_subdomain, with: new_company_attributes[:subdomain]
      fill_in :company_owner_attributes_full_name, with: new_company_attributes[:owner_full_name]
      fill_in :company_owner_attributes_email, with: new_company_attributes[:owner_email]
      fill_in :company_owner_attributes_password, with: new_company_attributes[:owner_password]
      fill_in :company_owner_attributes_password_confirmation, with: new_company_attributes[:owner_password]

      click_on "Create Company"
    end

    expect(page).to have_content(new_company_attributes[:title])
    expect(page).to have_content(new_company_attributes[:owner_full_name])
  end
end
