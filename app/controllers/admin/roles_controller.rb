class Admin::RolesController < Admin::BaseController
  resource_actions :crud

  def after_save_redirect_path
    admin_roles_path
  end
  alias :after_destroy_redirect_path :after_save_redirect_path

  def permitted_params
    params.require(:role).permit(:name)
  end
end