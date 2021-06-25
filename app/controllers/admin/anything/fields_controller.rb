class Admin::Anything::FieldsController < Admin::Anything::BaseController

  def index
  end

  private

  def collection_record
    @collection_record ||= ::Anything::Collection.find(params[:collection_id])
  end
  helper_method :collection_record

  def back_path
    admin_anything_collection_fields_path(collection_record)
  end
  helper_method :back_path

  def current_tab_pane
    :fields
  end
end
