module Companies
  module Posts
    class CommentsController < BaseController
      expose(:post, parent: :current_company)
      expose(:comments, from: :post)
      expose(:comment, parent: :post)

      respond_to :json

      before_action :authenticate_user!, only: %i(create update destroy)

      def index
        respond_with comments.order(created_at: :desc).page(params[:page])
      end

      def create
        comment.author = current_user
        authorize comment, :create?
        comment.save
        respond_with(comment, serializer: CommentSerializer, location: nil, status: 201)
      end

      def update
        authorize comment, :manage?
        comment.update(comment_params)
        respond_with(comment, location: nil, json: comment, serializer: CommentSerializer)
      end

      def destroy
        authorize comment, :manage?
        comment.destroy
        render nothing: true, status: 204
      end

      private

      def comment_params
        params.require(:comment).permit(:text)
      end
    end
  end
end
