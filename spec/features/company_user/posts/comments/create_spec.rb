require "rails_helper"

feature "Create Company Post Comments", js: true do
  let!(:company) { create(:company, :with_owner) }
  let!(:current_user) { create(:user, subdomain: company.subdomain) }
  let!(:post) { create(:post, company: company, author: current_user) }

  let(:comment_selector) { ".post-comments-item" }
  let(:comment_form_selector) { ".comments-form" }
  let(:new_comment_text) { "Super Post Text" }

  background do
    login_as current_user, scope: :user
  end

  scenario "Company member creates company post comment" do
    switch_to_subdomain(company.subdomain)

    visit post_path(post)

    within comment_form_selector do
      fill_in :comment_text, with: new_comment_text

      click_on "Save"
    end

    expect_to_have_new_comment_data
  end

  # rubocop:disable AbcSize
  def expect_to_have_new_comment_data
    within comment_selector do
      expect(page).to have_content(new_comment_text)
      expect(page).to have_content(current_user.full_name)
      expect(page).to have_link("Edit")
      expect(page).to have_link("Destroy")
    end
  end
  # rubocop:enable AbcSize
end
