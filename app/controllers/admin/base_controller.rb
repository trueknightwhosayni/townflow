class Admin::BaseController < AuthenticatedController
  layout 'admin'

  before_action :ensure_superuser

  private

  def ensure_superuser
    return if user_signed_in? && current_user.respond_to_role?(Role::SUPERUSER)

    redirect_to root_path
  end
end