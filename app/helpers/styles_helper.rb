module StylesHelper
  def active_pane(name, options={})
    " active " if current_tab_pane == name || (options[:default] && current_tab_pane.blank?)
  end
end
