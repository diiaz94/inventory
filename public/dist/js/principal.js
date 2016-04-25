
$( document ).ready(function() {
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
			    window.location.href = url;
			  })
			  .fail(function( msg ){
			  	debugger;
			  	alert("FAIL ::"+msg)
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
validarMensajes();

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

var products = [];
function fill_products_for_store(){

$.ajax("/deposits/"+this.value+"/products.json").done(
	function(data){
		$("select.select2#download_product_id").html("");

		$.each(data,function( index, obj ) {
	 			$("select.select2#download_product_id").append(
	 				"<option data-index ="+index+" value='"+obj.id+"'>"+obj.nombre_marca+" - "+obj.precio+" Bs.</option>"
	 			) 
		});
		products = data;	
		$("select.select2#download_product_id").select2();
        $("select.select2#download_product_id").trigger("change");
	});
}

function calculate_price(){
debugger
var product = products[$($(this).find("option:selected")).data("index")]
var precio_base = typeof(product)!==undefined ? product.precio : products[0].precio
$("#download_precio").val(precio_base+(precio_base*0.30))


}