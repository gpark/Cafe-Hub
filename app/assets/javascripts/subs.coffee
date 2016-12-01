# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $(".subs-week-select").on "change", ->
    $.ajax
      url: "/subs/change_week"
      type: "GET"
      dataType: "script"
      data:
        selected_week: $('.subs-week-select option:selected').val()