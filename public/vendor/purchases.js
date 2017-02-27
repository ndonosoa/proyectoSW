
$('#btn_revisar_ordenes').on('click', function(e){
  e.preventDefault();
  $('#contenedor_principal').toggleClass('hide');
  $('#detalle_ordenes').toggleClass('hide');
  //'<tr><td><div><strong></strong></div><small></small></td><td>1</td><td>$26.00</td></tr>'
  var total = 0;
  $('#datatables_orden tbody tr').each(function(i,row){
    //console.log(row);
   // console.log($(this).children()); //.innerText
    var cont=0; var subt = 0; var c = "";
    $(this).children().each(function(a,b){
      //console.log(b.firstChild.valueAsNumber, b.innerText);
      cont++;
      switch(cont){
        case 1: c += '<tr><td><div><strong>' + b.innerText + '</strong></div></td>'; break;
        case 3: cant = parseInt(b.firstChild.value); c+= '<td>' + cant + '</td>'; break;
        case 4: precio = parseInt(b.firstChild.value);c += '<td>' + precio + '</td>';break;
        case 5:  subt = cant * precio; c += '<td>' + subt + '</td></tr>'; break;
        default:break;
      }
      
    });
      $('#preview_orden_detalle').append(c);
      total = total + subt;
  }) ;
    $('#precio_total').text(total);
    console.log(total);

});




$('#btn_volver_ordenes').on('click', function(e){
  e.preventDefault();
  $('#contenedor_principal').toggleClass('hide');
  $('#detalle_ordenes').toggleClass('hide'); 
});





$(function () {
     //var t1 = $('#tabla1').DataTable();
     var t2 = $('#datatables_orden').DataTable({"bPaginate": false});

     $(document).on('click', '.boton_select', function(e){
      var id = $(this).data('id'); 
      //alert($(this).closest('tr').attr('id'));    
      //var prod = $('#prod_'+id).text();
      var prod = $(this).closest('tr').find('td').eq(0).text();
      var categoria = $(this).closest('tr').find('td').eq(3).text();
      //alert($(this).closest('tr').find('td').eq(0).text());
      //var stock = $('#stock_'+id).text();
      var tr = $(this).closest('tr');

      tr.toggleClass('hide');

      var row = t2.row.add([prod,categoria,'<input class="cantidad" name="cantidad" type="number" min="1" value="1">','<input class="precio" name="precio" type="number">','<span class="subt" style="font-weight: bold;"></span>','<button class="deselect btn btn-danger" data-id='+id+'>X</button>']).draw(false).node();
      //$(row).find('td').eq(5).data('id', id);
      
     });

  $(document).on('keyup', '.precio', function(e){
  var cantidad = $(this).closest('tr').find('.cantidad').val();
  var subt = $(this).closest('tr').find('.subt');
  var precio = $(this).val();
  var subtotal = cantidad*precio;
  subt.text('$ '+subtotal);
  });


  $(document).on('keyup', '.cantidad', function(e){
  var precio = $(this).closest('tr').find('.precio').val();
  var subt = $(this).closest('tr').find('.subt');
  var cantidad = $(this).val();
  var subtotal = cantidad*precio;
  subt.text('$ '+subtotal);
  });

     $(document).on('click','.deselect', function(e){
      var id = $(this).data('id');     
      t2.row($(this).parents('tr')).remove().draw();
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
      //console.log(result);
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
              return '<button data-id="'+row.id+'"  data-tr="'+iDataIndex+'" id="select_'+row.id+'" class="btn btn-xs btn-primary boton_select">+</button>'
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

