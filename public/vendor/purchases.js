$(function () {
  $('#datatables').dataTable({
   "ajax": "/purchases/json/getpurchases",
   "sAjaxDataProp": "purchases",
   "columns": [
   {"data": "id"},
   {"data":"name_provider",
   "render": function(data,type,row,meta){
    return '<a href="/provider/">'+row.name_provider+'</a>'
  }  
},
{"data":"created_at"}, 
{"data":"total_purchase"},          
{ "data": "id", 
"sClass": "text-center","orderable": false,"searchable": false,
"render": function(data,type,row,meta){
  return '<button data-id="'+row.id+'" class="btn btn-xs btn-primary2 revisar_ficha hide_on_big"><i class="fa fa-address-card-o fa-2"></i></button>  <a href="/purchase/details/"'+row.id+'><button title="Ver Ficha" data-id="'+row.id+'" class="btn btn-xs btn-primary2 revisar_ficha_big"><i class="fa fa-paste"></i></button></a>  <button title="Editar" class="btn btn-xs btn-info modal_editar" type="button" data-id="'+row.id+'"><i class="fa fa-pencil"></i></button>  <button title="Eliminar" class="btn btn-xs btn-danger eliminar_registro" data-campo="'+row.id+'" type="button"><i class="fa fa-trash-o"></i> <span class="bold"></span></button>'
}
} 
],
});
});



$('#btn_revisar_ordenes').on('click', function(e){
  e.preventDefault();
  $('#contenedor_principal').toggleClass('hide');
  $('#detalle_ordenes').toggleClass('hide');
  var total = 0;
  $('#datatables_orden tbody tr').each(function(i,row){
    //console.log(row);
    //console.log($(this).children()); //.innerText
    var cont=0; var subt = 0; var c = "";
    $(this).children().each(function(a,b){
     // console.log(b);
     cont++;
     switch(cont){
      case 1: c += '<tr><td><div><strong>' + b.innerText + '</strong></div></td>'; break;
      case 3: var o = parseInt(b.firstChild.value);
              if(isNaN(o))
                cant = 1;
              else
                cant = o; 
              c+= '<td>' + cant + '</td>'; break;
      case 4: var r = parseInt(b.firstChild.value);
              if(isNaN(r))
                precio = 1;
              else
                precio = r; 
              c += '<td>' + precio + '</td>';break;
      case 5:  subt = cant * precio; c += '<td>' + subt + '</td></tr>'; break;
      default:break;
    }

  });
    $('#preview_orden_detalle').append(c);
    total = total + subt;
  }) ;
  $('#precio_total').text(total);
    //console.log(total);

  });

$('#btn_volver_ordenes').on('click', function(e){
  e.preventDefault();
  $('#contenedor_principal').toggleClass('hide');
  $('#detalle_ordenes').toggleClass('hide');
  $('#preview_orden_detalle').empty(); 
});



$(function () {
     //var t1 = $('#tabla1').DataTable();
     var t2 = $('#datatables_orden').DataTable({"bPaginate": false,"searching": false});

     $(document).on('click', '.boton_select', function(e){
      var id = $(this).data('id');
      var value = parseInt($(this).data('campo'));
      if($('#datatables_orden').length != 0){     
        $('#btn_revisar_ordenes').removeAttr('disabled');
        $('#btn_generar_orden').removeAttr('disabled');
      }

      var prod = $(this).closest('tr').find('td').eq(0).text();
      var categoria = $(this).closest('tr').find('td').eq(3).text();
      //alert($(this).closest('tr').find('td').eq(0).text());
      //var stock = $('#stock_'+id).text();
      var tr = $(this).closest('tr');

      tr.toggleClass('hide');

      var row = t2.row.add([prod,categoria,'<input class="cantidad" name="cantidad" id="'+id+'" type="text"  value="1"  style="text-align:right;">','<input class="precio" name="precio" type="text" value="'+value+'" style="text-align:right;" >','<span class="subt" style="font-weight: bold;">'+value+'</span>','<button class="deselect btn btn-danger" id="'+id+'" data-id='+id+'>X</button>']).draw(false).node();
      //$(row).find('td').eq(5).data('id', id);
      
    });


  //función para validar solo numeros en el precio, además genera el subtotal correspondiente
  $(document).on('keyup', '.precio', function(e){
    var cantidad = $(this).closest('tr').find('.cantidad').val();
    var subt = $(this).closest('tr').find('.subt');
    var precio = $(this).val();
    var val = $(this).val();
    var total_validation = 0;
    var asd = 0;
    if (val.match(/[^0-9]/g)) {
      asd = parseInt(val.replace(/[^0-9]/g, ''));
      console.log(asd, val);
      if(isNaN(asd))
      {
        $(this).val(1);
        precio = 1;
      }
      else{
        $(this).val(asd);
        precio = parseInt($(this).val());
      }     
    }
    var subtotal = cantidad*precio;
    subt.text('$ '+subtotal); 
  });

//función para validar solo numeros en la cantidad, además genera el subtotal correspondiente
$(document).on('keyup', '.cantidad', function(e){
  var precio = $(this).closest('tr').find('.precio').val();
  var subt = $(this).closest('tr').find('.subt');
  var cantidad = $(this).val(); 
  var val = $(this).val();
  if (val.match(/[^0-9]/g)) {
    asd = parseInt(val.replace(/[^0-9]/g, ''));
    if(isNaN(asd))
    {
      $(this).val(1);
      cantidad = 1;
    }
    else{
      $(this).val(asd);
      cantidad = parseInt($(this).val());
    }     
  }
  var subtotal = cantidad*precio;
  subt.text('$ '+subtotal); 
});

$(document).on('click','.deselect', function(e){
  var id = $(this).data('id');     
  t2.row($(this).parents('tr')).remove().draw();
  var tabla = $('#datatables_orden').DataTable();

  if(tabla.data().length == 0){
    $('#btn_revisar_ordenes').attr('disabled','disabled');
    $('#btn_generar_orden').attr('disabled','disabled');
  }
      //$('#tr_'+id).toggleClass('hide');
      //alert($('#select_'+id).closest('tr').attr('id'));
      var idtabla1 = $('#select_'+id).closest('tr').attr('id');
      $('#'+idtabla1).toggleClass('hide');
    });   

});





$('#btn_filtrar_proveedor').on('click', function(e){
    e.preventDefault();
    var select = $('#proveedor_id_form').val();
    $('#contenedor_principal').toggleClass('hide');
    $('#contenedor_proveedores').toggleClass('hide'); 
    $.get("/purchases/json/getproductosorden/"+select,function(result){
      var table = $('#datatables_producto').DataTable();
      table.clear().draw();
      table.rows.add(result.productos).draw();
    }); 
  })
$('#btn_mostrar_filtro').on('click', function(e){
  e.preventDefault();
  var table = $('#datatables_producto').DataTable();
  table.clear().draw();
  var table2 = $('#datatables_orden').DataTable();
  table2.clear().draw();
  $('#contenedor_proveedores').toggleClass('hide');
  $('#contenedor_principal').toggleClass('hide');
})


 //    "sAjaxDataProp": "productos",

var table = $('#datatables_producto').dataTable({
      "data": [],
      'fnCreatedRow': function (nRow, aData, iDataIndex) {
        $(nRow).attr('id', 'tr_' + iDataIndex); // or whatever you choose to set as the id
    },
     "columns": [
        {"data":"name_product"},
        {"data":"code_product"},
        {"data":"name_provider"},           
        {"data": "name_category" },
        {"data": "name_brand" },
        { "data": "id", 
        "sClass": "text-center","orderable": false,"searchable": false,
           "render": function(data,type,row,meta,iDataIndex){
              return '<button data-id="'+row.id+'" data-campo="'+row.price_product+'" data-tr="'+iDataIndex+'" id="select_'+row.id+'" class="btn btn-xs btn-primary boton_select" >+</button>'
           }
        } 
     ],
  });

$.fn.extend({
  animateCss: function (animationName) {
    var animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
    this.addClass('animated ' + animationName).one(animationEnd, function() {
      $(this).removeClass('animated ' + animationName);
    });
  }
});

