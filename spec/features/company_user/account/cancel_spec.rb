require "rails_helper"

feature "Cancel Account" do
  include_context "company user signed in"

  background do
    switch_to_subdomain(company.subdomain)

    visit edit_user_registration_path
  end

  scenario "User cancels account" do
    click_link "Cancel my account"

    expect(page).to have_content("Bye! Your account has been successfully cancelled. We hope to see you again soon.")

    visit new_user_session_path
    fill_form(:user, current_user.attributes.slice(:email, :password))
    click_button "Sign in"

    expect(page).to have_content("Invalid email or password.")
  end
end
