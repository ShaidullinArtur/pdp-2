require "rails_helper"

describe Shared::SortQuery do
  describe "#all" do
    let(:params) { { sort: sort } }
    subject { described_class.new(User.all, params).all.to_sql }

    context "when users sortered by created_at" do
      let(:sort) { "created_at" }
      let(:ordering_values) { "ORDER BY created_at asc" }

      it { is_expected.to include(ordering_values) }
    end

    context "when users sortered by min rating and posts count" do
      let(:sort) { "-posts_count,average_rating" }
      let(:ordering_values) { "ORDER BY posts_count desc, average_rating asc" }

      it { is_expected.to include(ordering_values) }
    end
  end
end
