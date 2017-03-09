$(document).on('click', '.revisar_ficha_big', function(e){
    $('#contenedor_historial').toggleClass('hide');
    $('#contenedor_principal').toggleClass('hide');
    var product = $(this).data('product');
    var provider = $(this).data('provider');
    var code = $(this).data('code');
    var id = $(this).data('id');
      $('#datatables_historial').dataTable({
     "ajax": "/products/json/gethistorial/"+id,
     "sAjaxDataProp": "historial",
     "columns":[ 
        {"data":"price_history"},
        {"data": "quantity_stock_history"},
        {"data": "created_at"}          
     ],
  });

});
$('#btn_volver').on('click', function(){
  $('#contenedor_historial').toggleClass('hide');
  $('#contenedor_principal').toggleClass('hide');
  var table = $('#datatables_historial').DataTable();
  table.clear().draw();
  table.destroy();
})







$(document).on('click', '.eliminar_registro', function (e){
  e.preventDefault();
  var form = $('#form_delete');
  var url = form.attr('action').replace(':campo_id', $(this).data('campo'));
  var row = $(this).parents('tr');
  var dt = $('#datatables').DataTable();
  //console.log(url)
  swal({ title: "Está seguro?", text: "Se eliminara el registro.", type: "warning", showCancelButton: true, confirmButtonColor: "#f05050", confirmButtonText: "Si, Eliminarlo!"
}).then(function () { 
    $.delete(url,data,function(result){
      
      dt.row(row).remove().draw();
    swal({ title: 'Eliminado!', text: 'El registro fue eliminado correctamente.', type: "success", timer: 1500 }).catch(swal.noop);
    }); 
}).catch(swal.noop);
});




//Validaciones
$('#price_product_form').on('keyup', function(e) {
    var val = $(this).val();
   if (val.match(/[^0-9]/g)) {
       $(this).val(val.replace(/[^0-9]/g, ''));
   }
});
$('#stock_product_form').on('keyup', function(e) {
    var val = $(this).val();
   if (val.match(/[^0-9]/g)) {
       $(this).val(val.replace(/[^0-9]/g, ''));
   }
});

//boton eliminar
$(document).on('click', '.eliminar_registro', function (e){
  e.preventDefault();
  var form = $('#form_delete');
  var url = form.attr('action').replace(':campo_id', $(this).data('campo'));
  var data = form.serialize();
  var row = $(this).parents('tr');
  var dt = $('#datatables').DataTable();
  swal({ title: "Está seguro?", text: "Se eliminara el registro.", type: "warning", showCancelButton: true, confirmButtonColor: "#f05050", confirmButtonText: "Si, Eliminarlo!"
}).then(function () { 
    $.post(url,data,function(result){
      
      dt.row(row).remove().draw();
    swal({ title: 'Eliminado!', text: 'El registro fue eliminado correctamente.', type: "success", timer: 1500 }).catch(swal.noop);
    }); 
}).catch(swal.noop);
});


$.fn.extend({
  animateCss: function (animationName) {
    var animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
    this.addClass('animated ' + animationName).one(animationEnd, function() {
      $(this).removeClass('animated ' + animationName);
    });
  }
});

$(document).on('click', '#modal_nuevo', function (e){
  e.preventDefault();
  $('.help-block').text('');
  $('#title_form').text('Agregar Producto');
  $('#form-registro')[0].reset();
  $('#form_tipo').val('1'); 
  $('#modal_new_edit').modal('show');                
});  
//abre el modal, limpia el bloque de texto (clase helpblock) resetea formulario 
$(document).on('keypress', ':input', function(){
  $('#error_'+$(this).attr('name')).text('');
});

$(document).on('click', '.modal_editar', function (e){
  e.preventDefault();
  $('.help-block').text('');
  $('#title_form').text('Modificar Producto');
  $('#form-registro')[0].reset();
  $.get("products/"+$(this).data('id')+"/edit")
  .done(function(result){ 
console.log(result);
$('#nombre_product_form').val(result.product.name_product).animateCss('fadeIn');
$('#code_product_form').val(result.product.code_product).animateCss('fadeIn');
$('#price_product_form').val(result.product.price_product).animateCss('fadeIn');
$('#stock_product_form').val(result.product.stock_product).animateCss('fadeIn');
$('#provider_id_form').val(result.product.provider_id).animateCss('fadeIn');
$('#category_id_form').val(result.product.category_id).animateCss('fadeIn');
$('#brand_id_form').val(result.product.brand_id).animateCss('fadeIn');

});   
$('#form_tipo').val('2'); //tipo 2 para editar
$('#form_id_model').val($(this).data('id')); 
$('#modal_new_edit').modal('show');                
});  

//Guardar o Editar
$(function () {
  $('#form-registro').submit(function(e) { 
   e.preventDefault();       
   $('.help-block').text('');
   var t = $('#datatables').DataTable(); var f_t = $('#form_tipo').val();
   var form = $('#form-registro'); var url = form.attr('action'); 

   if(f_t == 2){
    var id_model = $('#form_id_model').val();
    var data = $('#form-registro :not(#form_tipo,#form_id_model)').serialize(); 
    url = url+'/'+id_model;
  }else{
    var data = $('#form-registro :not(#form_tipo,#form_id_model,#form_method)').serialize(); 
  }

  $.post(url, data, function(result){
  }).done(function(result){
        //console.log(result);
        $('#modal_new_edit').modal('hide');                
        if(f_t == 2){ 
      //$("#datatables").DataTable().row('#'+id_model).remove().draw(); //comentar si son màs de 500 registros
        swal({ title: "Modificado", text: "Producto modificada correctamente.", type: "success", timer: 1500 });
     }else{
      swal({ title: "Agregado", text: "Producto agregada correctamente.", type: "success", timer: 1500 });
     }
      $('#datatables').DataTable().ajax.reload( null, false ); //cambiar cuando la tabla tenga màs de 500 registros o sea usada por màs de una persona
      //t.row.add( { "odeplan_product":result.odeplan_product,"nombre_product":result.nombre_product, "id_product":result.id_product} ).draw(); //comentar si son màs de 500 registros
     }).error(function(xhr){
      //console.log(e);
      var errors = $.parseJSON(xhr.responseText).errors;
      //var e = error.responseJSON;
      console.log(errors);
      $.each( e, function( key, value ) {
      //console.log(key, value[0]);
      $('#error_'+key).append(value[0]).animateCss('fadeIn');
      });
      if(f_t == 2){
        //swal({ title: 'Error!', text: 'El registro no pudo ser modificado.', type: "error", timer: 1500 });
        }else{
        //swal({ title: 'Error!', text: 'El registro no pudo ser agregado.', type: "error", timer: 1500 });
        }
     });

  })
});

