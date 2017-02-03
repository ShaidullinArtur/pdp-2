require "rails_helper"

feature "Create Company Post Comments", js: true do
  let!(:company) { create(:company, :with_owner) }
  let!(:post) { create(:post, company: company, author: company.owner) }

  let(:comment_form_selector) { ".comments-form" }

  scenario "Visitor creates company post comment" do
    switch_to_subdomain(company.subdomain)

    visit post_path(post)

    expect(page).not_to have_selector(comment_form_selector)
  end
end
