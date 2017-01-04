require "rails_helper"

feature "Destroy Company Posts", js: true do
  let!(:company) { create(:company, :with_owner) }
  let!(:company_owner) { company.owner }
  let!(:company_member) { create(:user, subdomain: company.subdomain) }
  let!(:company_owner_post) { create(:post, company: company, author: company_owner) }
  let!(:company_member_post) { create(:post, company: company, author: company_member) }

  let(:post_selector) { ".blog-post" }
  let(:success_destroy_post_text) { "Post was successfully destroyed." }

  background do
    login_as company_owner
    switch_to_subdomain(company.subdomain)
  end

  scenario "Company owner deletes self post" do
    visit post_path(company_owner_post)

    click_on "Destroy"

    expect(page).not_to have_content(company_owner_post.text)
    expect(page).to have_content(success_destroy_post_text)
    expect(page).to have_selector(post_selector, count: 1)
  end

  scenario "Company owner deletes company member post" do
    visit post_path(company_member_post)

    click_on "Destroy"

    expect(page).not_to have_content(company_member_post.text)
    expect(page).to have_content(success_destroy_post_text)
    expect(page).to have_selector(post_selector, count: 1)
  end
end
