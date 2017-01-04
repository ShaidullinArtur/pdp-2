require "rails_helper"

feature "Destroy Company Post Comments", js: true do
  let!(:company) { create(:company, :with_owner) }
  let!(:company_owner) { company.owner }
  let!(:company_member) { create(:user, subdomain: company.subdomain) }
  let!(:post) { create(:post, company: company, author: company_owner) }
  let!(:company_owner_comment) { create(:comment, post: post, author: company_owner) }
  let!(:self_comment) { create(:comment, post: post, author: company_member) }

  let(:comment_selector) { ".post-comments-item" }

  background do
    login_as company_member
    switch_to_subdomain(company.subdomain)
  end

  scenario "Company member deletes self comment" do
    visit post_path(post)

    within comment_selector, text: self_comment.text do
      click_on "Destroy"
    end

    expect(page).not_to have_content(self_comment.text)
    expect(page).to have_selector(comment_selector, count: 1)
  end

  scenario "Company member deletes another company member comment" do
    visit post_path(post)

    within comment_selector, text: company_owner_comment.text do
      expect(page).not_to have_link("Destroy")
    end
  end
end
