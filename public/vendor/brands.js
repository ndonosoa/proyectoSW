$("#nombre_brand_form").on('keyup', function(e) {
    var val = $(this).val();
   if (val.match(/[^a-zA-ZáéíóúÁÉÍÓÚñÑ\s]/g)) {
       $(this).val(val.replace(/[^a-zA-ZáéíóúÁÉÍÓÚñÑ\s]/g, ''));
   }
});

$(function () {
  $('#datatables').dataTable({
     "ajax": "/brands/json/getbrands",
     "sAjaxDataProp": "brand",
     "columns": [
        {"data":"name_brand"},           
        { "data": "id", 
        "sClass": "text-center","orderable": false,"searchable": false,
           "render": function(data,type,row,meta){
              return '<button title="Editar" class="btn btn-xs btn-info modal_editar" type="button" data-id="'+row.id+'"><i class="fa fa-pencil"></i></button>  <button title="Eliminar" class="btn btn-xs btn-danger eliminar_registro" data-campo="'+row.id+'" type="button"><i class="fa fa-trash-o"></i> <span class="bold"></span></button>'
           }
        } 
     ],
  });
});

$(document).on('click', '.eliminar_registro', function (e){
  e.preventDefault();
  var id = $(this).data('campo');
  var form = $('#form_delete');
  var url = form.attr('action').replace(':campo_id', $(this).data('campo'));
  var data = form.serialize();
  var row = $(this).parents('tr');
  var dt = $('#datatables').DataTable();
swal({ title: "Está seguro?", text: "Se eliminara el registro.", type: "warning", showCancelButton: true, confirmButtonColor: "#f05050", confirmButtonText: "Si, Eliminarlo!"
}).then(function () {
     $.ajax({
      type: "PUT",
      url: "/brands/delete/"+id,
      success: function(){
    dt.row(row).remove().draw();
    swal({ title: 'Eliminado!', text: 'El registro fue eliminado correctamente.', type: "success", timer: 1500 }).catch(swal.noop);}
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
  $('#title_form').text('Agregar Marca');
  $('#form-registro')[0].reset();
  $('#form_tipo').val('1'); 
  $('#modal_new_edit').modal('show');                
});  
//abre el modal, limpia el bloque de texto (clase helpblock) resetea formulario 
$(document).on('keypress', ':input', function(){
  var a = $(this).attr('name');
  var res = a.replace("brand[", "").replace("]", "");

  $('#error_'+res).text('');
});

$(document).on('click', '.modal_editar', function (e){
  e.preventDefault();
  $('.help-block').text('');
  $('#title_form').text('Modificar Marca');
  $('#form-registro')[0].reset();
  $.get("brands/"+$(this).data('id')+"/edit")
  .done(function(result){ 
console.log(result);
$('#odeplan_brand_form').val(result.brand.odeplan_brand).animateCss('fadeIn');
$('#nombre_brand_form').val(result.brand.name_brand).animateCss('fadeIn');
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
   var val = $('#nombre_brand_form').val();
   if (val.match(/^\s*|\s*$/g)) {
        $('#nombre_brand_form').val(val.replace(/^\s*|\s*$/g, ''));
        
   }
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
        swal({ title: "Modificado", text: "Marca modificada correctamente.", type: "success", timer: 1500 });
     }else{
      swal({ title: "Agregado", text: "Marca agregada correctamente.", type: "success", timer: 1500 });
     }
      $('#datatables').DataTable().ajax.reload( null, false ); //cambiar cuando la tabla tenga màs de 500 registros o sea usada por màs de una persona
      //t.row.add( { "odeplan_brand":result.odeplan_brand,"nombre_brand":result.nombre_brand, "id_brand":result.id_brand} ).draw(); //comentar si son màs de 500 registros
     }).error(function(xhr){
      //console.log(evt,xhr,status,error);
      var errors = $.parseJSON(xhr.responseText);
      //var e = error.responseJSON;
      $.each( errors, function( i,item ) {
      //console.log(value[0], key, value.name_region[0], value.odeplan_region[0]);
      console.log(item);
          $.each( item, function( a,b) {
            $('#error_'+a).append(b).animateCss('fadeIn');
            //console.log(a);
            //console.log(b);
           // console.log('#error_'+a);
          });
      //$('#error_'+key).append(value[0]).animateCss('fadeIn');
      });
      if(f_t == 2){
        //swal({ title: 'Error!', text: 'El registro no pudo ser modificado.', type: "error", timer: 1500 });
        }else{
        //swal({ title: 'Error!', text: 'El registro no pudo ser agregado.', type: "error", timer: 1500 });
        }
     });

  })
});



