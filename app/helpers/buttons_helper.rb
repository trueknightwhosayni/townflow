module ButtonsHelper
  def admin_button(title, url, options={})
    icon = options.delete(:icon)
    body = icon ? "<i class='material-icons'>#{icon}</i><span>#{title}</span>" : "<span>#{title}</span>"

    link_to body.html_safe, url, { class: 'btn btn-danger waves-effect' }.merge(options)
  end

  def app_button()
    icon = options.delete(:icon)
    body = icon ? "<i class='material-icons'>#{icon}</i><span>#{title}</span>" : "<span>#{title}</span>"

    link_to body.html_safe, url, { class: 'btn btn-info waves-effect' }.merge(options)
  end

  def add_button(title, url, options={})
    link_to "<i class='material-icons'>plus_one</i> #{title}".html_safe, url, { class: 'btn btn-info waves-effect' }.merge(options)
  end

  def edit_button(url, options={})
    link_to "<i class='material-icons'>edit</i>".html_safe, url, options
  end

  def delete_button(url, options={})
    link_to "<i class='material-icons'>delete</i>".html_safe, url, { method: :delete, data: { confirm: 'Are you sure?' } }.merge(options)
  end

  def back_button(url, options={})
    link_to "<i class='material-icons'>arrow_back_ios</i><span>Back</span>".html_safe, url, { class: 'btn btn-default waves-effect' }.merge(options)
  end

  def show_button(url, options={})
    link_to "<i class='material-icons'>remove_red_eye</i>".html_safe, url, options
  end

  def submit_button(title, options={})
    button_tag title, { type: 'submit', class: 'btn btn-default waves-effect' }.merge(options)
  end
end