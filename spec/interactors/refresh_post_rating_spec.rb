require "rails_helper"

describe RefreshPostRating do
  let!(:company) { create(:company, :with_owner) }
  let!(:user) { company.owner }
  let!(:post) { create(:post, author: user, company: company, rating: 0) }
  let!(:ratings) do
    [
      create(:rating, :with_user, post: post, value: 1),
      create(:rating, :with_user, post: post, value: 2)
    ]
  end

  subject { described_class.call(post: post) }

  it "recalculate post rating" do
    expect { subject }.to change { post.rating }.from(0).to(1.5)
  end

  it "recalculate post author average rating" do
    expect { subject }.to change { post.author.average_rating }.to(1.5)
  end
end
