$(function () {
  $('#datatables').dataTable({
     "ajax": "/regions/json/getregions",
     "sAjaxDataProp": "region",
     "columns": [
        {"data":"odeplan_region"},
        {"data":"name_region"},           
        { "data": "id", 
        "sClass": "text-center","orderable": false,"searchable": false,
           "render": function(data,type,row,meta){
              return '<button data-id="'+row.id+'" class="btn btn-xs btn-primary2 revisar_ficha hide_on_big"><i class="fa fa-address-card-o fa-2"></i></button>                                 <button title="Ver Ficha" data-id="'+row.id+'" class="btn btn-xs btn-primary2 revisar_ficha_big"><i class="fa fa-paste"></i></button>   <button title="Editar" class="btn btn-xs btn-info modal_editar" type="button" data-id="'+row.id+'"><i class="fa fa-pencil"></i></button>  <button title="Eliminar" class="btn btn-xs btn-danger eliminar_registro" data-campo="'+row.id+'" type="button"><i class="fa fa-trash-o"></i> <span class="bold"></span></button>'
           }
        } 
     ],
  });
});


$(document).on('click', '.eliminar_registro', function (e){
  e.preventDefault();
  var form = $('#form_delete');
  var url = form.attr('action').replace(':campo_id', $(this).data('campo'));
  var data = form.serialize();
  var row = $(this).parents('tr');
  var dt = $('#datatables').DataTable();
  //console.log(url)
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
  $('#title_form').text('Agregar Región');
  $('#form-registro')[0].reset();
  $('#form_tipo').val('1'); 
  $('#modal_new_edit').modal('show');                
});  
//abre el modal, limpia el bloque de texto (clase helpblock) resetea formulario 
$(document).on('keypress', ':input', function(){
  var a = $(this).attr('name');
  var res = a.replace("region[", "").replace("]", "");

  $('#error_'+res).text('');
});

$(document).on('click', '.modal_editar', function (e){
  e.preventDefault();
  $('.help-block').text('');
  $('#title_form').text('Modificar Región');
  $('#form-registro')[0].reset();
  $.get("regions/"+$(this).data('id')+"/edit")
  .done(function(result){ 
//console.log(result);
$('#odeplan_region_form').val(result.region.odeplan_region).animateCss('fadeIn');
$('#nombre_region_form').val(result.region.name_region).animateCss('fadeIn');
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
        swal({ title: "Modificado", text: "Región modificada correctamente.", type: "success", timer: 1500 });
     }else{
      swal({ title: "Agregado", text: "Región agregada correctamente.", type: "success", timer: 1500 });
     }
      $('#datatables').DataTable().ajax.reload( null, false ); //cambiar cuando la tabla tenga màs de 500 registros o sea usada por màs de una persona
      //t.row.add( { "odeplan_region":result.odeplan_region,"nombre_region":result.nombre_region, "id_region":result.id_region} ).draw(); //comentar si son màs de 500 registros
     }).error(function(xhr){
      //console.log(evt,xhr,status,error);
      var errors = $.parseJSON(xhr.responseText);
      //var e = error.responseJSON;
      //console.log(errors);
      $.each( errors, function( i,item ) {
      //console.log(value[0], key, value.name_region[0], value.odeplan_region[0]);
      console.log(item);
          $.each( item, function( a,b) {
            console.log(b);
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

