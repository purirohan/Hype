# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  $('.api-tab').click ->
    $('.nav-tabs').find('li').removeClass('active')
    $(this).parent('li').addClass('active')
    tab = ($(this).attr('class').split(" ")[1])
    $('.content-block').removeClass('active')
    $('#' + tab).addClass('active')
