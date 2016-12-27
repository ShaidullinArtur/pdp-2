require "rails_helper"

feature "Edit Company Post Comments", js: true do
  let!(:company) { create(:company, :with_owner) }
  let!(:company_owner) { company.owner }
  let!(:post) { create(:post, company: company, author: company_owner) }
  let!(:comment) { create(:comment, post: post, author: company_owner) }

  let(:comment_selector) { ".post-comments-item" }


  scenario "Visitor updates company member comment" do
    switch_to_subdomain(company.subdomain)

    visit post_path(post)

    within comment_selector, text: comment.text do
      expect(page).not_to have_link("Edit")
    end
  end
end
