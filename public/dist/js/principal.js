
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
	    $("#new_bill").on("click",initSelectBill);
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




function initSelectBill(){
	var row = $("#row-products")	
	row.removeClass("hidden");
	var select = $(row.find("select"))
	$.ajax("/seller/store/products.json").done(
	function(data){
		alert(JSON.stringify(data));
		select.html("");
		$.each(data,function( index, obj ) {
	 			select.append(
	 				"<option data-index ="+index+" value='"+obj.id+"'>"+obj.codigo_nombre_marca+" (Quedan "+obj.cantidad+")</option>"
	 			) 
		});
		select.select2();
		//$("label[for='download_cantidad'").text("Cantidad (Quedan "+product.cantidad+" en depósito)")
       	// $("select.select2#download_product_id").trigger("change");
	}).error(
		function(data){
			alert(data.responseText);
		}
	);
}



