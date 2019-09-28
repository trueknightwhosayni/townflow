class Admin::UsersController < Admin::BaseController
  resource_actions :crud
  paginate_collection 20

  def update
    if permitted_params[:password].present?
      success = current_user.update(permitted_params)
    else
      success = current_user.update_without_password(permitted_params)
    end

    if success
      sign_in current_user, bypass: true
      redirect_to after_save_redirect_path
    else
      render :edit
    end
  end

  def after_save_redirect_path
    admin_users_path
  end
  alias :after_destroy_redirect_path :after_save_redirect_path

  def permitted_params
    params.require(:user).permit(:email, :password, role_ids: [], group_ids: [])
  end
end