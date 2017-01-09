module Companies
  class PostsController < BaseController
    expose(:posts, -> { current_company.posts.includes(:author).order(created_at: :desc) })
    expose(:post, parent: :current_company)
    expose(:comments, from: :post)

    helper_method :serialized_post, :serialized_comments

    before_action :authenticate_user!, only: %i(new create edit update destroy)

    def index
    end

    def new
    end

    def create
      authorize post, :create?
      post.author = current_user
      post.save
      respond_with post
    end

    def show
    end

    def edit
      authorize post, :manage?
    end

    def update
      authorize post, :manage?
      post.update(post_params)
      respond_with post
    end

    def destroy
      authorize post, :manage?
      post.destroy
      respond_with post
    end

    private

    def post_params
      params.require(:post).permit(:title, :text)
    end

    def serialized_post
      if current_user.present?
        serialize(post, serializer: UserPostSerializer, scope: current_user, scope_name: :current_user)
      else
        serialize(post)
      end
    end

    def serialized_comments
      serialize(comments.includes(:author).order(created_at: :desc).page(1))
    end
  end
end
