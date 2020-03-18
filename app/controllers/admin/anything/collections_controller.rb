class Admin::Anything::CollectionsController < Admin::Anything::BaseCollectionsController
  resource_actions :new, :create, :edit, :update, :destroy
  resource_class 'Anything::Collection'

  def index
    @folders = current_folder.present? ? current_folder.children : ::Anything::Folder.roots
    @collections = current_folder.present? ? current_folder.collections : ::Anything::Collection.roots
  end

  def update
    update! do |format|
      unless resource.errors.empty? # failure
        format.html { redirect_to project_url(resource) }
      end
    end
  end

  private

  def build_resource
    @collection = current_user.owned_collections.build
  end

  def back_path
    current_folder.present? && current_folder.parent_id.present? ? admin_anything_collections_path(folder_id: current_folder.parent_id) : admin_anything_collections_path
  end
  helper_method :back_path

  def form_back_path
    params[:id].present? ? admin_anything_collections_path(folder_id: resource.folder_id) : back_path
  end
  helper_method :form_back_path

  def current_folder
    @current_folder ||= params[:folder_id].present? ? ::Anything::Folder.find_by(id: params[:folder_id]) : nil
  end
  helper_method :current_folder

  def after_save_redirect_path
    edit_admin_anything_collection_path(resource)
  end
  alias :after_destroy_redirect_path :back_path

  def permitted_params
    params.require(:anything_collection).permit(:title, :folder_id)
  end
end