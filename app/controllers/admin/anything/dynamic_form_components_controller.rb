class Admin::Anything::DynamicFormComponentsController < Admin::Anything::BaseController
  respond_to :js

  def index
    render params[:component]
  end
end