class Admin::Anything::FieldsController < Admin::Anything::BaseController
  private

  def back_path
    edit_admin_anything_collection_path(resource)
  end
  helper_method :back_path

  # def permitted_params
  #   params.require(:anything_folder).permit(:title, :parent_id)
  # end
end