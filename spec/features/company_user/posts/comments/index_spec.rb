require "rails_helper"

feature "Company Post Comments Index", js: true do
  let!(:company) { create(:company, :with_owner) }
  let!(:current_user) { create(:user, subdomain: company.subdomain) }
  let!(:post) { create(:post, company: company, author: current_user) }
  let!(:comments) { create_list(:comment, 2, post: post, author: current_user) }

  let(:comment_selector) { ".post-comments-item" }

  background do
    login_as current_user
  end

  scenario "Company member sees post comments list" do
    switch_to_subdomain(company.subdomain)

    visit post_path(post)

    expect(page).to have_selector(comment_selector, count: comments.count)
    comments.each(&method(:expect_to_have_comment_data))
  end

  # rubocop:disable AbcSize
  def expect_to_have_comment_data(comment)
    within comment_selector, text: comment.text do
      expect(page).to have_content(comment.text)
      expect(page).to have_content(comment.author.full_name)
    end
  end
  # rubocop:enable AbcSize
end
