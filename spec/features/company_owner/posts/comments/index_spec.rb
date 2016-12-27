require "rails_helper"

feature "Company Post Comments Index", js: true do
  let!(:company) { create(:company, :with_owner) }
  let!(:company_owner) { company.owner }
  let!(:post) { create(:post, company: company, author: company_owner) }
  let!(:comments) { create_list(:comment, 2, post: post, author: company_owner) }

  let(:comment_selector) { ".post-comments-item" }

  background do
    login_as company_owner
  end

  scenario "Company owner sees post comments list" do
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
