require "rails_helper"

describe FilteredUsersQuery do
  let!(:users) do
    [
      create(:user, posts_count: 1, average_rating: 0, email: "super_user@mail.com"),
      create(:user, posts_count: 1, average_rating: 1),
      create(:user, posts_count: 4, average_rating: 2),
      create(:user, posts_count: 4, average_rating: 3, email: "super_admin@mail.com"),
      create(:user, posts_count: 3, average_rating: 4),
      create(:user, posts_count: 2, average_rating: 5, email: "user@mail.com")
    ]
  end

  describe "#all" do
    subject { described_class.new(User.all, params).all }

    context "when users filtered by min rating" do
      let(:params) { { min_rating: 2 } }
      let(:filtered_users) { users[2..-1] }

      it { is_expected.to match_array(filtered_users) }
    end

    context "when users sortered by min rating and posts count" do
      let(:params) { { sort: "-posts_count,-average_rating" } }
      let(:filtered_users) { [users[3], users[2], users[4], users[5], users[1], users[0]] }

      it { is_expected.to match_array(filtered_users) }
    end

    context "when users sortered by min rating and posts count" do
      let(:params) { { search: "super" } }
      let(:filtered_users) { [users[0], users[3]] }

      it { is_expected.to match_array(filtered_users) }
    end

    context "when users filtered by pagination" do
      let!(:users) { create_list(:user, 35) }

      let(:params) { { sort: "id", page: 1 } }
      let(:filtered_users) { User.limit(25) }

      it { is_expected.to match_array(filtered_users) }
    end
  end
end
