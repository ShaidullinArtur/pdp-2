require "rails_helper"

feature "Post Ratings", js: true do
  let!(:company) { create(:company, :with_owner) }
  let!(:post) { create(:post, company: company, author: company.owner) }

  let(:post_details_selector) { ".post-box" }
  let(:stars_selector) { ".star-rating" }

  scenario "Visitor can't set post rating" do
    switch_to_subdomain(company.subdomain)

    visit post_path(post)

    expect(post_details_selector).not_to have_selector(stars_selector)
  end
end
