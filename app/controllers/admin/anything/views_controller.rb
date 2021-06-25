class Admin::Anything::ViewsController < Admin::Anything::BaseCollectionsController
  resource_actions :new, :create, :edit, :update, :destroy
  resource_class 'Anything::Folder'

  private

  def back_path
    current_folder.present? && current_folder.parent_id.present? ? admin_anything_collections_path(folder_id: current_folder.parent_id) : admin_anything_collections_path
  end
  helper_method :back_path

  def current_folder
    @current_folder ||= params[:folder_id].present? || params[:id].present? ? ::Anything::Folder.find_by(id: params[:folder_id] || params[:id]) : nil
  end
  helper_method :current_folder

  def after_save_redirect_path
    admin_anything_collections_path
  end
  alias :after_destroy_redirect_path :back_path

  def permitted_params
    params.require(:anything_folder).permit(:title, :parent_id)
  end

  def current_tab_pane
    :views
  end
end
