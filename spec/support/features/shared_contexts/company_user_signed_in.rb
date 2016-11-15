shared_context "company user signed in" do
  let(:company) { create :company, :with_owner }
  let(:current_user) { create :user, subdomain: company.subdomain }

  background do
    login_as current_user
  end
end
