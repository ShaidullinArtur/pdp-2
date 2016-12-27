require "rails_helper"

feature "Company Posts Index " do
  let!(:company) { create(:company, :with_owner) }
  let!(:posts) { create_list(:post, 2, company: company, author: current_user) }

  let(:current_user) { company.owner }
  let(:post_selector) { ".blog-post" }

  background do
    login_as current_user
  end

  scenario "Visitor sees posts list" do
    switch_to_subdomain(company.subdomain)

    visit root_path

    expect(page).to have_selector(post_selector, count: posts.count)
    posts.each(&method(:expect_to_have_post_data))
  end

  # rubocop:disable AbcSize
  def expect_to_have_post_data(post)
    within ".blog-post[data-id='#{post.id}']" do
      expect(page).to have_content(post.title)
      expect(page).to have_content(I18n.l(post.created_at, format: :us_date))
      expect(page).to have_content(post.author.full_name)
      expect(page).to have_content(post.rating)
    end
  end
  # rubocop:enable AbcSize
end
