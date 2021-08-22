// TODO5: this part from original bootstrap doesn't work for some reasons

$(document).ready(function(){
  $('ul.nav.nav-tabs[role=tablist] li a').click(function (e) {
    $(this).parent('li').parent('ul').find('li.active').removeClass('active')
    $(this).parent('li').addClass('active')
  })

  $('body').on('focusin', '.form-control', function(e) {
    $(this).closest('.form-line').addClass('focused')
  })

  $('body').on('focusout', '.form-control', function(e) {
    if (!$(this).val())
      $(this).closest('.form-line').removeClass('focused')
  })
})
