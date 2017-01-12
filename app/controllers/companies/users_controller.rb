module Companies
  class UsersController < BaseController
    expose(:users, -> { FilteredUsersQuery.new(current_company.users, params).all })

    helper_method :serialized_users

    before_action :authenticate_user!

    def index
      respond_to do |format|
        format.html
        format.json do
          render json: users
        end
      end
    end

    private

    def serialized_users
      serialize(users.page(1))
    end
  end
end
