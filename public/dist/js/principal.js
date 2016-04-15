

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

});
