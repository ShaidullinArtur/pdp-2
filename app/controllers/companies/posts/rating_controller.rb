module Companies
  module Posts
    class RatingController < BaseController
      expose(:post, parent: :current_company)
      expose(:rating, -> { post.ratings.find_or_initialize_by(user: current_user) })

      before_action :authenticate_user!

      def update
        rating.update(rating_params)
        RefreshPostRating.call(post: post)
        render json: post
      end

      private

      def rating_params
        params.require(:rating).permit(:value)
      end
    end
  end
end
