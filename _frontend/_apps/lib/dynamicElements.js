function askForRemoteRender(e, dataBuilder) {
  const selectInput = e.target
  const scriptUrl = $(selectInput).data('url')

  let data = {
    element: $(selectInput).data("element"),
    value: $(selectInput).val(),
    field_id: $(selectInput).attr('id')
  }

  if (dataBuilder) {
    data = Object.assign(data, dataBuilder(e));
  }

  const req = {
    url: scriptUrl,
    dataType: "script",
    data: data,
    success: function() {}
  }

  jQuery.ajax(req);
}

export const initDynamicElements = () =>
  // RUN GLOBAL WATCHER
  $(document).ready(function() {
    $('body').on('change', 'select.dynamicElement', function(e) {
      askForRemoteRender(e, null);
    })
  })


export const customDynamicElement = (selector, dataBuilder) =>
  $('body').on('change', selector, function(e) {
    askForRemoteRender(e, dataBuilder);
  })
