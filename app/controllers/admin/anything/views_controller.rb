class Admin::Anything::ViewsController < Admin::Anything::BaseCollectionsController
  resource_actions :new, :create, :edit, :update, :destroy
  resource_context :collection_record

  private

  def collection_record
    @collection_record ||= ::Anything::Collection.find(params[:collection_id])
  end
  helper_method :collection_record

  def back_path
    admin_anything_collection_views_path(collection_record)
  end
  helper_method :back_path

  alias :after_save_redirect_path :back_path
  alias :after_destroy_redirect_path :back_path

  def permitted_params
    params.require(:anything_view).permit(:title, :view_type, view_fields_attributes: [:id, :field_id, :_destroy])
  end

  def current_tab_pane
    :views
  end
end
