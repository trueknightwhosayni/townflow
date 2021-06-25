class Admin::GroupsController < Admin::BaseController
  resource_actions :crud

  def create
    build_resource
    resource.owner = current_user

    create!
  end

  def after_save_redirect_path
    admin_groups_path
  end
  alias :after_destroy_redirect_path :after_save_redirect_path

  def permitted_params
    params.require(:group).permit(:title, role_ids: [])
  end
end