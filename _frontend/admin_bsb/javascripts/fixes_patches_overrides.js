// TODO5: this part from original bootstrap doesn't work for some reasons

$(document).ready(function(){
  $('ul.nav.nav-tabs[role=tablist] li a').click(function (e) {
    $(this).parent('li').parent('ul').find('li.active').removeClass('active')
    $(this).parent('li').addClass('active')
  })
})
