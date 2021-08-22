class Admin::Erp::SectionsController < Admin::Anything::BaseCollectionsController
  resource_actions :crud
  resource_class 'Erp::Section'

  def create
    build_resource
    resource.document_renderer_class = Erp::Renderers::Document.name
    resource.list_renderer_class = Erp::Renderers::List.name
    resource.new_item_processor_attributes = fetch_renderer_attributes!(:new_item_processor_attributes)
    resource.document_renderer_attributes = fetch_renderer_attributes!(:document_renderer_attributes)
    resource.list_renderer_attributes = fetch_renderer_attributes!(:list_renderer_attributes)

    create!
  end

  def update
    resource.new_item_processor_attributes = fetch_renderer_attributes!(:new_item_processor_attributes)
    resource.document_renderer_attributes = fetch_renderer_attributes!(:document_renderer_attributes)
    resource.list_renderer_attributes = fetch_renderer_attributes!(:list_renderer_attributes)

    update!
  end

  private

  def fetch_renderer_attributes!(name)
    data = permitted_params[name].presence.dup || {}
    params[:erp_section].delete name

    if data.present? && data.to_h.all? { |_, v| v.present? }
      return data.to_json
    end

    nil
  end

  def back_path
    admin_erp_section_categories_path(category_id: resource.section_category_id)
  end
  helper_method :back_path

  alias :after_save_redirect_path :back_path
  alias :after_destroy_redirect_path :back_path

  def permitted_params
    params.require(:erp_section).permit(:section_category_id, :anything_collection_id, :key, :title, :icon,
      :allow_editing, :allow_deleting, :new_item_processor_class,
      new_item_processor_attributes: [:form_id, :process_id],
      document_renderer_attributes: [:view_id], list_renderer_attributes: [:view_id]
    )
  end
end
