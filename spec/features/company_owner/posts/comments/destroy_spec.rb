require "rails_helper"

feature "Destroy Company Post Comments", js: true do
  let!(:company) { create(:company, :with_owner) }
  let!(:company_owner) { company.owner }
  let!(:company_member) { create(:user, subdomain: company.subdomain) }
  let!(:post) { create(:post, company: company, author: company_owner) }
  let!(:company_member_comment) { create(:comment, post: post, author: company_member) }
  let!(:self_comment) { create(:comment, post: post, author: company_owner) }

  let(:comment_selector) { ".post-comments-item" }

  background do
    login_as company_owner, scope: :user
    switch_to_subdomain(company.subdomain)
  end

  scenario "Company owner deletes self comment" do
    visit post_path(post)

    within comment_selector, text: self_comment.text do
      click_on "Destroy"
    end

    expect(page).not_to have_content(self_comment.text)
    expect(page).to have_selector(comment_selector, count: 1)
  end

  scenario "Company owner deletes company member comment" do
    visit post_path(post)

    within comment_selector, text: company_member_comment.text do
      click_on "Destroy"
    end

    expect(page).not_to have_content(company_member_comment.text)
    expect(page).to have_selector(comment_selector, count: 1)
  end
end
