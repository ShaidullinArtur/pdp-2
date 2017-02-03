require "rails_helper"

feature "Destroy Company Posts" do
  let!(:company) { create(:company, :with_owner) }
  let!(:post) { create(:post, company: company, author: company.owner) }

  let(:post_details_selector) { ".post-box" }

  scenario "Visitor can't delete company post" do
    switch_to_subdomain(company.subdomain)

    visit post_path(post)

    expect(post_details_selector).not_to have_content("Destroy")
  end
end
