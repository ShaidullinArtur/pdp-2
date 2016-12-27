require "rails_helper"

feature "Destroy Company Posts" do
  let!(:company) { create(:company, :with_owner) }
  let!(:company_member) { create(:user, subdomain: company.subdomain) }
  let!(:company_owner_post) { create(:post, company: company, author: company.owner) }
  let!(:company_member_post) { create(:post, company: company, author: company_member) }

  let(:post_details_selector) { ".post-box" }
  let(:post_selector) { ".blog-post" }
  let(:success_destroy_post_text) { "Post was successfully destroyed." }

  background do
    login_as company_member
    switch_to_subdomain(company.subdomain)
  end

  scenario "Company member deletes self post" do
    visit post_path(company_member_post)

    click_on "Destroy"

    expect(page).to have_content(success_destroy_post_text)
    expect(page).to have_selector(post_selector, count: 1)
  end

  scenario "Company member deletes another company member post" do
    visit post_path(company_owner_post)

    expect(post_details_selector).not_to have_content("Destroy")
  end
end
