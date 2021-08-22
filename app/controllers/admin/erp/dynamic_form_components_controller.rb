class Admin::Erp::DynamicFormComponentsController < Admin::Anything::BaseController
  respond_to :js

  def index
    render params[:element]
  end
end
