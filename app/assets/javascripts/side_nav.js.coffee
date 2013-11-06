$ ->
  $('.side-nav').on 'click', '.collapsable', ->
    $(this).toggleClass('closed').toggleClass('open')
