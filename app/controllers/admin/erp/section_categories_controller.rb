class Admin::Erp::SectionCategoriesController < Admin::Anything::BaseCollectionsController
  resource_actions :crud
  resource_class 'Erp::SectionCategory'

  def index
    @sections = current_category.present? ? current_category.sections : []
  end

  private

  def collection
    @collection ||= current_category.present? ? current_category.children : ::Erp::SectionCategory.roots
  end

  def back_path
    params[:category_id].present? ? admin_erp_section_categories_path(category_id: params[:category_id]) : admin_erp_section_categories_path
  end
  helper_method :back_path

  def current_category
    @current_category ||= params[:category_id].present? || params[:id].present? ? ::Erp::SectionCategory.find_by(id: params[:category_id] || params[:id]) : nil
  end
  helper_method :current_category

  alias :after_save_redirect_path :back_path
  alias :after_destroy_redirect_path :back_path

  def permitted_params
    params.require(:erp_section_category).permit(:title, :key, :icon, :parent_id)
  end
end
