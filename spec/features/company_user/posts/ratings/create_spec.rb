require "rails_helper"

feature "Post Ratings", js: true do
  let!(:company) { create(:company, :with_owner) }
  let!(:company_owner) { company.owner }
  let!(:company_member) { create(:user, subdomain: company.subdomain) }
  let!(:post) { create(:post, company: company, author: post_author, rating: 1.5) }

  let(:post_details_selector) { ".post-box" }
  let(:post_current_rating_selector) { ".post-current-rating" }
  let(:post_user_rating_selector) { ".post-user-rating" }
  let(:star_selector) { ".star-rating .fa.fa-lg" }
  let(:active_star_selector) { ".fa.fa-lg.fa-star" }
  let(:inactive_star_selector) { ".fa.fa-lg.fa-star-o" }

  background do
    login_as company_member, scope: :user
    switch_to_subdomain(company.subdomain)
  end

  context "when user are post author" do
    let(:post_author) { company_member }

    scenario "Company user can't set post rating" do
      visit post_path(post)

      expect(post_details_selector).not_to have_selector(post_user_rating_selector)
    end
  end

  context "when user are not post author" do
    let(:post_author) { company_owner }
    let!(:post_rating) { create(:rating, post: post, user: company_owner, value: 1) }
    let!(:user_post_rating) { create(:rating, post: post, user: company_member, value: 2) }

    scenario "Company user set post rating" do
      visit post_path(post)

      within post_current_rating_selector do
        expect(page).to have_content("Current rating:")
        expect(page).to have_selector(active_star_selector, count: 1)
        expect(page).to have_selector(inactive_star_selector, count: 4)
      end

      within post_user_rating_selector do
        expect(page).to have_selector(active_star_selector, count: 2)
        expect(page).to have_selector(inactive_star_selector, count: 3)

        all(star_selector)[2].trigger("click")
      end

      within post_current_rating_selector do
        expect(page).to have_content("Current rating:")
        expect(page).to have_selector(active_star_selector, count: 2)
        expect(page).to have_selector(inactive_star_selector, count: 3)
      end

      within post_user_rating_selector do
        expect(page).to have_selector(active_star_selector, count: 3)
        expect(page).to have_selector(inactive_star_selector, count: 2)
      end
    end
  end
end
