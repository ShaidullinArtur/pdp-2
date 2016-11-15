module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  end

  private

  def user_not_authorized
    if request.xhr?
      render json: { error: I18n.t("common.error_messages.access_denied") }, status: 404
    else
      flash[:alert] = I18n.t("common.error_messages.access_denied")
      redirect_to root_path
    end
  end

  def record_not_found
    if request.xhr?
      render json: { error: t("common.error_messages.record_not_found") }, status: 404
    else
      redirect_to root_path, alert: t("common.error_messages.record_not_found")
    end
  end
end
