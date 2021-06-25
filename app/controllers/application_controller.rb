class ApplicationController < ActionController::Base
  layout :layout_by_resource

  private

  def layout_by_resource
    devise_controller? ? 'devise' : 'application'
  end

  def current_tab_pane
    nil
  end
  helper_method :current_tab_pane
end
