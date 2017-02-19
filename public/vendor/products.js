$(function () {
  $('#example2').dataTable({
     "ajax": "/products/json/getproducts",
     "sAjaxDataProp": "productos",
     "columns": [
        {"data":"name_product"},
        {"data":"name_provider"},           
        {"data": "name_category" },
        {"data": "name_brand" },
        { "data": "id", 
        "sClass": "text-center","orderable": false,"searchable": false,
           "render": function(data,type,row,meta){
              return '<button data-id="'+row.id+'" class="btn btn-xs btn-primary2 revisar_ficha hide_on_big"><i class="fa fa-address-card-o fa-2"></i></button>                                 <button title="Ver Ficha" data-id="'+row.id+'" class="btn btn-xs btn-primary2 hide_on_small revisar_ficha_big"><i class="fa fa-paste"></i></button>   <button title="Editar" class="btn btn-xs btn-info modal_editar hide_on_small" type="button" data-id="'+row.id+'"><i class="fa fa-pencil"></i></button>  <button title="Eliminar" class="btn btn-xs btn-danger hide_on_small" data-campo="'+row.id+'" type="button"><i class="fa fa-trash-o"></i> <span class="bold"></span></button>'
           }
        } 
     ],
  });
});