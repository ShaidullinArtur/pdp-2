require "rails_helper"

feature "Company Users Index", js: true do
  let!(:subdomain) { "super-company" }
  let!(:company_owner) { create(:user, subdomain: subdomain, posts_count: 1, average_rating: 3.6) }
  let!(:company_member) { create(:user, subdomain: subdomain, posts_count: 3, average_rating: 2.1) }
  let!(:company) { create(:company, subdomain: subdomain, owner: company_owner) }
  let!(:users) do
    [
      company.owner,
      company_member,
      create(:user, subdomain: subdomain, posts_count: 2, average_rating: 2.5, email: "super_owner@mail.com"),
      create(:user, subdomain: subdomain, posts_count: 3, average_rating: 2.5, email: "user@mail.com"),
      create(:user, subdomain: subdomain, posts_count: 4, average_rating: 1.5, email: "super_user@mail.com")
    ]
  end
  let(:users_filtered_by_min_rating) { [users[0], users[1], users[2], users[3]] }
  let(:users_sortered_by_average_rating) { [users[0], users[3], users[2], users[1], users[4]] }
  let(:users_sortered_by_posts_count) { [users[4], users[3], users[1], users[2], users[0]] }
  let(:users_filtered_by_search) { [users[2], users[4]] }

  let(:filters_selector) { ".company-users-filters" }
  let(:user_selector) { ".company-users-item" }

  background do
    login_as company_member
    switch_to_subdomain(subdomain)

    visit users_path
  end

  scenario "Company user sees users list" do
    expect_to_have_users_data(users)
  end

  scenario "Company user filter users by min rating" do
    within filters_selector do
      select "2", from: :min_rating
    end

    expect_to_have_users_data(users_filtered_by_min_rating)
  end

  scenario "Company user filter users by search" do
    within filters_selector do
      fill_in :search, with: "super"
    end

    sleep 1

    expect_to_have_users_data(users_filtered_by_search)
  end

  scenario "Company user sort users by posts count" do
    within filters_selector do
      select "Posts Count", from: :sort
    end

    sleep 1

    expect_to_have_sortered_users_data(users_sortered_by_posts_count)
  end

  scenario "Company user sort users by average rating" do
    within filters_selector do
      select "Average Rating", from: :sort
    end

    sleep 1

    expect_to_have_sortered_users_data(users_sortered_by_average_rating)
  end

  # rubocop:disable AbcSize
  def expect_to_have_users_data(filtered_users)
    expect(page).to have_selector(user_selector, count: filtered_users.count)
    filtered_users.each { |user| expect_to_have_user_data(user) }
  end

  def expect_to_have_sortered_users_data(sortered_users)
    all(user_selector).each_with_index do |user_container, i|
      user = sortered_users[i]
      expect(user_container).to have_content(user.full_name)
      expect(user_container).to have_content(user.posts_count)
      expect(user_container).to have_content(user.average_rating)
    end
  end

  def expect_to_have_user_data(user)
    within ".company-users-item[data-id='#{user.id}']" do
      expect(page).to have_content(user.full_name)
      expect(page).to have_content(user.posts_count)
      expect(page).to have_content(user.average_rating)
    end
  end
  # rubocop:enable AbcSize
end
