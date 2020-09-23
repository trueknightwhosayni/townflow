module StylesHelper
  def active_pane(name, options={})
    " active " if params[:active_pane] == name || (options[:default] && params[:active_pane].blank?)
  end
end