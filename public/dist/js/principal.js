$.fn.pressEnter = function(fn) {  
  
    return this.each(function() {  
        $(this).bind('enterPress', fn);
        $(this).keyup(function(e){
            if(e.keyCode == 13)
            {
              $(this).trigger("enterPress");
            }
        })
    });  
 }; 


$( document ).ready(function() {
	var triggerChangeDeposit;
    console.log( "ready!" );
	$(".delete-record").on("click",function(){

		if(confirm("¿Esta seguro/a?")){
			url = $(this).data("url");
			id = $(this).data("id");
			$.ajax({
			  method: "DELETE",
			  url: url+"/"+id+".json",
			})
			  .done(function( msg ) {
			  	alert("Registro eliminado exitosamente.");
			    location.reload();
			  })
			  .fail(function(data){
					alert(data.responseText);
				});
		}
	});
  	$('.cedula').unbind();
  	$('.cedula').bind('keyup', function(){
		if(this.value.length>parseInt($(this).data("maxlength"))){
	    	this.value = this.value.substring(0,$(this).data("maxlength"))
	    }
	});

	$('.cedula').bind('keypress', function(){
		if(this.value.length>parseInt($(this).data("maxlength"))-1){
	    	this.value = this.value.substring(0,$(this).data("maxlength"))
	    }
	});
	
	    $("#new_bill").on("click",initBillModal);
	    $(".new_bill_for_owner").on("click",setOwnerUrls);
	    $("#add_sale").on("click",addBillSale);
	    $('#close-bill-modal').on("click",close_bill_modal);
	    $("#ok-bill").on("click",ok_bill);
	    $('#cantidad').pressEnter(addBillSale);
	    $("#cantidad").focus(function(){
	   		//alert("aaa");
    		});

	    $("#row-products").change(function(){
          setTimeout(function(){ $('#cantidad').trigger("focus"); }, 250);


        });
        $.each($(".monto"), function( index, value ) {
  			$(value).text(formato_numero($(value).text(), 2, ',', '.'))
		});
        //$(".monto").text(formato_numero($(".monto").text(), 2, ',', '.'));

	validarMensajes();
	$.ajaxSetup({
	  headers: {
	    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
	  }});

	$(".submit_client_date").submit(function(event){
		debugger
		var d = new Date();
		var fecha = {
			"dia":d.getDate(),
			"mes":d.getMonth()+1,
			"anio":d.getFullYear(),
			"hora":d.getHours(),
			"min":d.getMinutes(),
			"seg":d.getSeconds()
		}

		$(this).append(
			"<input type='hidden' name='fecha' value='"+JSON.stringify(fecha)+"'/>"
			);
		return 
		event.preventDefault();
	});

});

function validarMensajes(){
	if(typeof(alertmsj)!="undefined" && alertmsj.trim()!=""){
		$(".modal-danger").find("#msjtxt").html(alertmsj);
		$(".modal-danger").modal("show");
	}
	if(typeof(noticemsj)!="undefined" && noticemsj.trim()!=""){
		$(".modal-success").find("#msjtxt").html(noticemsj);
		$(".modal-success").modal("show");
		setTimeout(function(){ $(".modal-success").modal("hide")}, 1500);
	}
}


function validarErrores(array){

	if(typeof(array)!="undefined"){
		if(array.length){
			var obj = $("<ul><ul>")
			for (var i = 0; i <array.length; i++) {
				obj.append("<li>"+array[i].mensaje+"</li>")
			}
			alertmsj=obj.html();
			validarMensajes();
		}
	}
}

function initComerces(){
$.ajax("/owner/commerces.json").done(
	function(data){
		$("select.select2#comercio").html("");
		$.each(data,function( index, obj ) {
			if(obj.deposits_count>0){
				$("select.select2#comercio").append(
	 				"<option data-index ="+index+" value='"+obj.id+"'>"+obj.nombre+"</option>"
	 			) 
			}
		});
		$("select.select2#comercio").select2();
       	$("select.select2#comercio").trigger("change");
	}).error(
		function(data){
			alert(data.responseText);
		}
	);

}

function initDeposits(){
$.ajax("/owner/commerces/"+commerce_id+"/deposits.json").done(
	function(data){
		$("select.select2.deposits").html("");
		$.each(data,function( index, obj ) {
			if(obj.products_count>0){
				$("select.select2.deposits").append(
	 				"<option data-index ="+index+" value='"+obj.id+"'>"+obj.nombre+"</option>"
	 			) 
			}
		});
		$("select.select2.deposits").select2();
       	$("select.select2.deposits").trigger("change");
	}).error(
		function(data){
			alert(data.responseText);
		}
	);

}


function fill_deposits_for_commerce(){

$.ajax("/owner/commerces/"+this.value+"/deposits.json").done(
	function(data){
		$("select.select2.deposits").html("");
		$.each(data,function( index, obj ) {
			if (!triggerChangeDeposit||obj.products_count>0) {
	 			$("select.select2.deposits").append(
	 				"<option data-index ="+index+" value='"+obj.id+"'>"+obj.nombre+"</option>"
	 			) 
			}
		});
		$("select.select2.deposits").select2();
		if(triggerChangeDeposit){
		    $("select.select2.deposits").trigger("change");
		}
	}).error(
		function(data){
			alert(data.responseText)
		}
	);
}
function fill_stores_for_commerce(){

$.ajax("/owner/commerces/"+this.value+"/stores.json").done(
	function(data){
		$("select.select2.stores").html("");
		$.each(data,function( index, obj ) {
 			$("select.select2.stores").append(
 				"<option data-index ="+index+" value='"+obj.id+"'>"+obj.nombre+"</option>"
 			) 
		});
		$("select.select2.stores").select2();
	}).error(
		function(data){
			alert(data.responseText)
		}
	);
}

var products = [];
var commerce_id;
function fill_products_for_deposit(){
$.ajax("/owner/commerces/"+commerce_id+"/deposits/"+this.value+"/products.json").done(
	function(data){
		$("select.select2.products").html("");
		$.each(data,function( index, obj ) {
	 			$("select.select2.products").append(
	 				"<option data-index ="+index+" value='"+obj.id+"'>"+obj.nombre_marca+" (Quedan "+obj.cantidad+")</option>"
	 			) 
		});
		$("select.select2.products").select2();
		//$("label[for='download_cantidad'").text("Cantidad (Quedan "+product.cantidad+" en depósito)")
       	// $("select.select2#download_product_id").trigger("change");
	}).error(
		function(data){
			alert(data.responseText);
		}
	);
}

function graficoTortaInit(products_of_deposits,products_of_stores){


	 var pieChartCanvas = $("#pieChart").get(0).getContext("2d");
        var pieChart = new Chart(pieChartCanvas);
        var PieData = [
          {
            value: products_of_deposits,
            color: "#3c8dbc",
            highlight: "#3c8dbc",
            label: "Productos en Deposito"
          },
          {
            value: products_of_stores,
            color: "#00c0ef",
            highlight: "#00c0ef",
            label: "Productos en Tienda"
          }
        ];
        var pieOptions = {
          //Boolean - Whether we should show a stroke on each segment
          segmentShowStroke: true,
          //String - The colour of each segment stroke
          segmentStrokeColor: "#fff",
          //Number - The width of each segment stroke
          segmentStrokeWidth: 2,
          //Number - The percentage of the chart that we cut out of the middle
          percentageInnerCutout: 50, // This is 0 for Pie charts
          //Number - Amount of animation steps
          animationSteps: 100,
          //String - Animation easing effect
          animationEasing: "easeOutBounce",
          //Boolean - Whether we animate the rotation of the Doughnut
          animateRotate: true,
          //Boolean - Whether we animate scaling the Doughnut from the centre
          animateScale: false,
          //Boolean - whether to make the chart responsive to window resizing
          responsive: true,
          // Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
          maintainAspectRatio: true,
          //String - A legend template
          legendTemplate: "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>"
        };
        //Create pie or douhnut chart
        // You can switch between pie and douhnut using the method below.
        pieChart.Doughnut(PieData, pieOptions);
}


var billProducts =[]
var billProductsListed=[]
var totalBill=0;
var lastSelected=-1;
var url_store_products;
var url_create_bill;
var url_redirect;
function initBillModal(){

	$("#row-bill-detail table").addClass("hidden");
	$("#row-bill-detail #aviso").removeClass("hidden");
	$("#row-bill-detail #table-bill-detail").html("");
	$("#total-bill").text("Total 0 Bs.");	
	billProducts =[]
	billProductsListed=[]
	totalBill=0;
	lastSelected=-1
	$(".edit-sale").unbind();
	$(".ok-edit-sale").unbind();
	$(".delete-sale").unbind();
	initBillProducts();
}


function setOwnerUrls(){
//url_store_products = this.
	var url=$(this).data("url")
	var store=$(this).data("store")
	if (typeof(url)!="undefined") {
		url_store_products=url;
		store_id=store;
		initBillProducts();
	}
}


function initBillProducts(){

$.ajax({
  url: url_store_products,
  beforeSend: function( xhr ) {
	$("#modal-loader").modal({backdrop: 'static', keyboard: false}); 
  }
}).done(function( data ) {
    billProducts = data;
		$("#modal-bill").modal("show"); 
		initBillSelect();	
  }).error(
		function(data){
			alert(data.responseText);
		}
	).always(function() {
   		$("#modal-loader").modal("hide");
  });

}

function initBillSelect(){
	
	if (typeof(billProducts)!="undefined") {
		var row = $("#row-products")	
		row.removeClass("hidden");
		var select = $(row.find("select"))
		select.html("");
		$.each(billProducts,function(index, obj) {
			//if (obj.cantidad>0) {
				select.append(
					"<option"+(index==lastSelected?" selected='selected'":"")+" data-index ="+index+" value='"+obj.id+"'>"+obj.codigo_nombre_marca+" (Quedan "+obj.cantidad+")</option>"
			 		) 
			//}
		});
		select.select2();
	}

}


function addBillSale(){
		var existsProducts = $.grep(billProducts, function(n,i) { 
			return n.cantidad>0; 
		});
	if (existsProducts.length>0 && $("#cantidad").val().length>0) {
		$("#ok-bill").removeAttr("disabled");
		$("#ok-bill").removeClass("disabled");
		var cantidad=parseInt($("#cantidad").val());
		var optionSelected = $("#row-products select option:selected");
		lastSelected=optionSelected.data("index");	
		var productSelect = billProducts[lastSelected];
		var tableSales = $("#row-bill-detail #table-bill-detail")
		if (cantidad<1) {
			alert("Disculpa, la cantidad debe ser mayor a 1");
		}else{
			if (cantidad>productSelect.cantidad) {
				alert("Disculpa, debes escoger una cantidad menor para este producto");
			}else{
				$("#row-bill-detail table").removeClass("hidden");
				$("#row-bill-detail #aviso").addClass("hidden");
				var sale = {id:productSelect.id, nombre:productSelect.nombre,marca:productSelect.marca,cantidad:cantidad, precio:productSelect.precio};
				var index ;
				var previusSelecteds= $.grep(billProductsListed, function(n,i) { 
						index=n.id == sale.id?i:index;
						return n.id == sale.id; 
				})
				if (previusSelecteds.length==0) {
					billProductsListed.push(sale);
					//alert(JSON.stringify(productSelect));
					totalBill+=(sale.precio*cantidad);
					tableSales.append(
						"<tr style='display:none'>"+
						"<td class='codigo'>"+sale.id+"</td>"+
						"<td>"+sale.nombre+"</td>"+
						"<td>"+sale.marca+"</td>"+
						"<td class='cantidad'> "+ 
							"<input class='form-control hidden new-cantidad' value='"+sale.cantidad+"'  type='number'>"+
							"<span class='current-cantidad'>"+sale.cantidad+"</span>"+
							"<i class='edit-sale fa fa-fw fa-edit' title='Editar cantidad'></i>"+
							"<i class='ok-edit-sale fa fa-fw fa-check hidden'title='Guardar cambio'></i></td>"+
						"<td class='precio'>"+formato_numero(sale.precio, 2, ',', '.')+" <i title='Eliminar esta fila' style='float:right'class='delete-sale fa fa-fw fa-close'></i></td>"+
						"</tr>");
					tableSales.children().last().fadeIn();
					$(".edit-sale").unbind();
					$(".edit-sale").bind("click",edit_sale);
					$(".ok-edit-sale").unbind();
					$(".ok-edit-sale").bind("click",ok_edit_sale);
					$(".delete-sale").unbind();
					$(".delete-sale").bind("click",delete_sale);
				}else{
					totalBill+=(billProductsListed[index].precio*cantidad);				
					billProductsListed[index].cantidad = parseInt(billProductsListed[index].cantidad) + parseInt(cantidad);
					$(tableSales.children()[index]).find(".current-cantidad").text(billProductsListed[index].cantidad); 
					$(tableSales.children()[index]).find(".new-cantidad").val(billProductsListed[index].cantidad); 
				}
				$("#total-bill").text("Total "+formato_numero(totalBill, 2, ',', '.'));
				productSelect.cantidad = productSelect.cantidad-cantidad; 
				initBillSelect();
			}
		}
	}
}

function edit_sale(){
	var element=$(this)
	element.addClass("hidden");
	element.siblings(".current-cantidad").addClass("hidden");
	element.siblings(".ok-edit-sale").removeClass("hidden");
	element.siblings(".new-cantidad").removeClass("hidden");


}

function ok_edit_sale(){

	var element=$(this)
	var id=element.closest("tr").find(".codigo").text();
	var find = $.grep(billProductsListed, function(n,i) { 
			return n.id==id; 
		})
	var index2;
	var findSelected = $.grep(billProducts, function(n,i) {
			index2=n.id == id?i:index2; 
					return n.id==id; 
			});

	if (find.length>0) {
		var sale=find[0];
		var productSelect = billProducts[index2];
		if (parseInt(element.siblings(".new-cantidad").val())-sale.cantidad>parseInt(productSelect.cantidad)) {
			alert("Disculpa, debes escoger una cantidad menor para este producto");
		}else{
			element.addClass("hidden");
			totalBill-=(parseInt(sale.cantidad)*sale.precio);
			productSelect.cantidad += parseInt(sale.cantidad); 
			sale.cantidad=parseInt(element.siblings(".new-cantidad").val());
			productSelect.cantidad -= parseInt(sale.cantidad); 
			totalBill+=(sale.cantidad*sale.precio);	
			element.siblings(".current-cantidad").text(sale.cantidad);
			element.siblings(".current-cantidad").removeClass("hidden");
			element.siblings(".edit-sale").removeClass("hidden");
			element.siblings(".new-cantidad").addClass("hidden");
			$("#total-bill").text("Total "+totalBill+" Bs.");
			initBillSelect();
		}
	}


	
}

function delete_sale(){
	var element=$(this);
	element.closest("tr").addClass("delete-tr");

	if (confirm("¿Estas seguro/a?")) {
		
		var id=element.closest("tr").find(".codigo").text();
		var index,index2;
		var find = $.grep(billProductsListed, function(n,i) {
			index=n.id == id?i:index; 
					return n.id==id; 
			});
		var findSelected = $.grep(billProducts, function(n,i) {
			index2=n.id == id?i:index2; 
					return n.id==id; 
			});

		if (find.length>0) {
			var sale=find[0];
			var productSelect = findSelected[0];
			productSelect.cantidad += parseInt(sale.cantidad); 
			initBillSelect();
			totalBill-=(parseInt(sale.cantidad)*sale.precio);
			$("#total-bill").text("Total "+totalBill+" Bs.");
			billProductsListed.splice(index,1);
			element.closest("tr").fadeOut();
			element.closest("tr").remove();
			if (billProductsListed.length==0) {
				$("#row-bill-detail table").addClass("hidden");
				$("#row-bill-detail #aviso").removeClass("hidden");
			}

		}
	}
	if (billProductsListed.length==0) {
		$("#ok-bill").attr("disabled",true);
	};
	element.closest("tr").removeClass("delete-tr");

}



function close_bill_modal(){
	if (confirm("¿Estas seguro/a?\n Se perderán todos los cambios realizados.")) {
		$("#modal-bill").modal("hide");
	}
}

function ok_bill(){
	if (confirm("¿Estas seguro/a?")) {
		procesarBill();
	}
}

function procesarBill(){
	$("#modal-bill").modal("hide");
	$("#modal-loader").modal("show");
	var d = new Date();
		var fecha = {
			"dia":d.getDate(),
			"mes":d.getMonth()+1,
			"anio":d.getFullYear(),
			"hora":d.getHours(),
			"min":d.getMinutes(),
			"seg":d.getSeconds()
		}
	$.ajax({
		method: "POST",
  		url: url_create_bill,
  		data: { 
  			sales: billProductsListed,
  			bill: {total: totalBill},
  			store_id: (typeof(store_id)!="undefined" ? store_id : ""),
  			fecha: JSON.stringify(fecha)
  		}
	}).done(
	function(data){
		$("#modal-loader").modal("hide");
		noticemsj ="Venta realizada exitosamente"
		validarMensajes();
		setTimeout(function(){ window.location.href = url_redirect;}, 1500);
	}).error(
		function(data){
	   		$("#modal-loader").modal("hide");
	   		$("#modal-bill").modal("hide");
			alert(data.responseText);
		}
	);
}


function formato_numero(numero, decimales, separador_decimal, separador_miles){ 
    numero=parseFloat(numero);
    if(isNaN(numero)){
        return "";
    }

    if(decimales!==undefined){
        // Redondeamos
        numero=numero.toFixed(decimales);
    }

    // Convertimos el punto en separador_decimal
    numero=numero.toString().replace(".", separador_decimal!==undefined ? separador_decimal : ",");

    if(separador_miles){
        // Añadimos los separadores de miles
        var miles=new RegExp("(-?[0-9]+)([0-9]{3})");
        while(miles.test(numero)) {
            numero=numero.replace(miles, "$1" + separador_miles + "$2");
        }
    }
    return numero+" Bs.";
    //Implementación formato_numero(numeroAFormatear, 2, ',', '.');
}