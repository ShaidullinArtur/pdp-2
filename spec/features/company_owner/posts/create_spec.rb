require "rails_helper"

feature "Create Company Posts" do
  let!(:company) { create(:company, :with_owner) }
  let!(:current_user) { company.owner }

  let(:post_form_selector) { "#new_post" }
  let(:new_post_title) { "Super Post Title" }
  let(:new_post_text) { "Super Post Text" }
  let(:success_create_post_text) { "Post was successfully created." }

  background do
    login_as current_user, scope: :user
  end

  scenario "Company owner creates company post", js: true do
    switch_to_subdomain(company.subdomain)

    visit new_post_path

    within post_form_selector do
      fill_in :post_title, with: new_post_title
      fill_in :post_text, with: new_post_text

      click_on "Create Post"
    end

    expect(page).to have_content(success_create_post_text)
    expect_to_have_new_post_data
  end

  # rubocop:disable AbcSize
  def expect_to_have_new_post_data
    expect(page).to have_content(new_post_title)
    expect(page).to have_content(new_post_text)
    expect(page).to have_content(current_user.full_name)
  end
  # rubocop:enable AbcSize
end
