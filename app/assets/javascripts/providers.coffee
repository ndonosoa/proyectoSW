# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#provider_city_id').parent().hide()
  cities = $('#provider_city_id').html()
  $('#provider_region_id').change ->
    region = $('#provider_region_id :selected').text()
    options = $(cities).filter("optgroup[label='#{region}']").html()
    if options
      $('#provider_city_id').html(options)
      $('#provider_city_id').parent().show()
    else
      $('#provider_city_id').empty()
      $('#provider_city_id').parent().hide()

