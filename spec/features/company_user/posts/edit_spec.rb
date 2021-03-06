require "rails_helper"

feature "Edit Company Posts", js: true do
  let!(:company) { create(:company, :with_owner) }
  let!(:company_member) { create(:user, subdomain: company.subdomain) }
  let!(:company_owner_post) { create(:post, company: company, author: company.owner) }
  let!(:company_member_post) { create(:post, company: company, author: company_member) }

  let(:post_details_selector) { ".post-box" }
  let(:post_form_selector) { ".edit_post" }
  let(:new_post_title) { "Super Post Title" }
  let(:new_post_text) { "Super Post Text" }
  let(:success_update_post_text) { "Post was successfully updated." }

  background do
    login_as company_member, scope: :user
    switch_to_subdomain(company.subdomain)
  end

  scenario "Company member updates self post" do
    visit post_path(company_member_post)

    click_on "Edit"

    within post_form_selector do
      fill_in :post_title, with: new_post_title
      fill_in :post_text, with: new_post_text

      click_on "Update Post"
    end

    expect(page).to have_content(success_update_post_text)
    expect_to_have_new_post_data
  end

  scenario "Company member updates another company member post" do
    visit post_path(company_owner_post)

    expect(post_details_selector).not_to have_content("Edit")
  end

  def expect_to_have_new_post_data
    expect(page).to have_content(new_post_title)
    expect(page).to have_content(new_post_text)
  end
end
