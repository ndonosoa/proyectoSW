
//funciones del Index


//Llena la tabla de ordenes de compra



$(function(){

  var fecha ;
  var id;
  var total;
  var proveedor;
  t2 = $('#datatables_pendiente').DataTable();
  $.get("/purchases/json/getpurchases", function(result){
    
    $(result.purchases).each(function(a, b){
        var i = 0;
      while(i < 4){
       // console.log(b.created_at,b.id,b.name_provider,b.total_purchase);
       // console.log(i);
       
        switch(i){
          case 0: fecha = (b.created_at).substring(0,10); break;
          case 1:  id = parseInt(b.id); break;
          case 2: proveedor = b.name_provider; break;
          case 3:  total = parseInt(b.total_purchase); break;
          default:break;}
          
        i = i +1;  
      }
     // console.log(fecha,id,proveedor,total);
          var row = t2.row.add([id,fecha,proveedor, total, '<button title="Ver Ficha" data-id="'+id+'" class="btn btn-xs btn-primary2 revisar_ficha_big"><i class="fa fa-paste"></i></button>  <button data-id="'+id+'" data-name_provider="'+proveedor+'" data-created_at="'+fecha+'" data-total_purchase="'+total+'"  class="btn btn-xs btn-primary boton_state" >Estado</button>']).draw(false).node();

    });
  });

  var id2;
  var e = 0;
$('#datatables_pendiente tr').each(function(c,d){
    console.log(d);
    $(d).each(function(e,f){
      console.log(f);
      if(e == 0){
        id2 = f.id;
      }
      e = e +1;
    })
    console.log(c);
  //var tr = $(this).closest('tr');
  //console.log(id);
 /* $.get('/purchases/json/getdetalleorden/'+id, function(result){
      (result.detalle).each(function(a,b){
        if(isEmpty(b)){
          tr.remove();
        }
      });
  });*/

});

});

/*$('#datatables_pendiente').dataTable({ 
   "columns": [
   {"data": "id"},
   {"data":"name_provider" },
{"data":"created_at"}, 
{"data":"total_purchase"},          
{ "data": "id", 
"sClass": "text-center","orderable": false,"searchable": false,
"render": function(data,type,row,meta){
  return  '<button title="Ver Ficha" data-id="'+row.id+'" class="btn btn-xs btn-primary2 revisar_ficha_big"><i class="fa fa-paste"></i></button>  <button data-id="'+row.id+'" data-name_provider="'+row.name_provider+'" data-created_at="'+row.created_at+'" data-total_purchase="'+row.total_purchase+'"  class="btn btn-xs btn-primary boton_state" >Estado</button>'
}
} 
],
});*/

  


$(function(){
    var table2 = $('#datatables_despachada').DataTable();

$(document).on('click', '.boton_state', function(e){
  e.preventDefault();
  var id = $(this).closest('tr').find('td').eq(0).text();
  var provider = $(this).closest('tr').find('td').eq(1).text();
  var date = $(this).closest('tr').find('td').eq(2).text();
  var total = $(this).closest('tr').find('td').eq(3).text();
  var tr = $(this).closest('tr');
  var obj = new Object();
  var f = 0;
  var cont = 0;
  obj.detalles = new Array();
  $.get("/purchases/json/getdetalleorden/"+id,function(result){

    $(result.detalle).each(function(f,b){
      //console.log(b.price_product);

      var i=0;
      obj.detalles[f] = new Object();
      //  console.log(a);
      while( i < 7){
        switch(i){
          case 4: obj.detalles[f].price_product = parseInt(b.price_purchase_detail); break;
          case 5: obj.detalles[f].product_id = parseInt(b.product_id); break;
          case 6: obj.detalles[f].stock_product = parseInt(b.quantity_product); break;
          default:break;
        }     
        
     // console.log(obj.detalles[f].price_product); 
      i =  i+ 1; };
      f = f +1;
      cont = f;     
      });
    if(f == 0){
    obj.purchase_id = result.detalle[0]["id"];
    obj.name_provider = result.detalle[0]["name_provider"];};
  });  
    swal({ title: "¿Está seguro?", text: "Se cambiará estado a Entregado", type: "warning", showCancelButton: true, confirmButtonColor: "#f05050", confirmButtonText: "Si, Cambiarlo!"
}).then(function () { 
    $.ajax({
    type: "PUT",
    url: "/purchases/updatedetail/"+id,
    data: {obj,cont},
    success: function() { 
      swal({ title: 'Eliminado!', text: 'La Orden fue actualizada correctamente', type: "success", timer: 1500 }).catch(swal.noop);
      table2.row.add([id,provider,date,total,'<button title="Ver Ficha" data-id="'+id+'" id="'+id+'" class="btn btn-xs btn-primary2 revisar_ficha_big"><i class="fa fa-paste"></i></button>']).draw();
      //$(row).find('td').eq(5).data('id', id);
      tr.remove();
    }

  });
    
}).catch(swal.noop);
 // console.log(id, provider, date, total);


    });
});

  

$(document).on('click', '.revisar_ficha_big', function(){
  $('#purchase_detail').toggleClass('hide');
  $('#purchase_show').toggleClass('hide');
  var id = $(this).data('id');
  $('#datatables_detalle').dataTable({
   "ajax": "/purchases/json/getdetalleorden/"+id,
   "sAjaxDataProp": "detalle",
   "columns": [
        {"data":"name_product"},
        {"data":"code_product"},
        {"data":"name_provider"},           
        {"data": "quantity_product" },
        {"data": "price_purchase_detail" }, 
     ],
}); 

});
$('#btn_mostrar_ordenes').on('click', function(){
  $('#purchase_detail').toggleClass('hide');
  $('#purchase_show').toggleClass('hide');
  var table = $('#datatables_detalle').DataTable();
  table.clear().draw();
  table.destroy();
});



//Funciones del new




$('#btn_revisar_ordenes').on('click', function(e){
  e.preventDefault();
  $('#contenedor_volver_op').toggleClass('hide');
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
  $('#contenedor_volver_op').toggleClass('hide');
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
      }

      var prod = $(this).closest('tr').find('td').eq(0).text();
      var stock = $(this).closest('tr').find('td').eq(2).text();
      //alert($(this).closest('tr').find('td').eq(0).text());
      //var stock = $('#stock_'+id).text();
      var tr = $(this).closest('tr');

      tr.toggleClass('hide');

      var row = t2.row.add([prod,stock,'<input class="cantidad" maxlength="3" name="cantidad" id="'+id+'" type="text"  value="1"  style="text-align:right;">','<input class="precio" maxlength="5" name="precio" type="text" value="'+value+'" style="text-align:right;" >','<span class="subt" style="font-weight: bold;">'+value+'</span>','<button class="deselect btn btn-danger" id="'+id+'" data-id='+id+'>X</button>']).draw(false).node();
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
   // $('#btn_mostrar_filtro').toggleClass('hide'); 
    $.get("/purchases/json/getproductosorden/"+select,function(result){
     // console.log(result);
      $('#nombre_proveedor').text("Proveedor: "+result.productos[0].name_provider); 
      var table = $('#datatables_producto').DataTable();
      table.clear().draw();
      table.rows.add(result.productos).draw();
    }); 
  })
$('#btn_mostrar_filtro').on('click', function(e){
  e.preventDefault();

  var comparar = String($('#contenedor_proveedores').attr("class"));
  //$('#btn_mostrar_filtro').toggleClass('hide');
//  console.log(comparar);
  
  if (comparar != "hpanel hide"){
      $(location).attr('href', '/purchases');
  }
  else{
  $('#contenedor_proveedores').toggleClass('hide');
  $('#contenedor_principal').toggleClass('hide');
  var table = $('#datatables_producto').DataTable();
  table.clear().draw();
  var table2 = $('#datatables_orden').DataTable();
  table2.clear().draw();
  }
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
        {"data":"stock_product"},           
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

