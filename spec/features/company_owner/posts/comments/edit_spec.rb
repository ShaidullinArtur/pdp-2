require "rails_helper"

feature "Edit Company Post Comments", js: true do
  let!(:company) { create(:company, :with_owner) }
  let!(:company_owner) { company.owner }
  let!(:company_member) { create(:user, subdomain: company.subdomain) }
  let!(:post) { create(:post, company: company, author: company_owner) }
  let!(:company_member_comment) { create(:comment, post: post, author: company_member) }
  let!(:self_comment) { create(:comment, post: post, author: company_owner) }

  let(:comment_selector) { ".post-comments-item" }
  let(:comment_form_selector) { ".comments-form" }
  let(:new_comment_text) { "Super Comment Text" }

  background do
    login_as company_owner, scope: :user
    switch_to_subdomain(company.subdomain)
  end

  scenario "Company owner updates self comment" do
    visit post_path(post)

    update_comment(self_comment)

    expect_to_have_updated_comment(self_comment)
  end

  scenario "Company owner updates company member comment" do
    visit post_path(post)

    update_comment(company_member_comment)

    expect_to_have_updated_comment(company_member_comment)
  end

  def update_comment(comment)
    within comment_selector, text: comment.text do
      click_on "Edit"

      within comment_form_selector do
        fill_in :comment_text, with: new_comment_text
        click_on "Save"
      end
    end
  end

  def expect_to_have_updated_comment(comment)
    within comment_selector, text: comment.text do
      expect(page).to have_content(new_comment_text)
    end
  end
end
