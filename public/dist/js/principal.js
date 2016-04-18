
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
validarMensajes();

});

function validarMensajes(){
	if(alertmsj!=undefined && alertmsj.trim()!=""){
		$(".modal-danger").find("#msjtxt").text(alertmsj);
		$(".modal-danger").modal("show");
	}
	if(noticemsj!=undefined && noticemsj.trim()!=""){
		$(".modal-success").find("#msjtxt").text(noticemsj);
		$(".modal-success").modal("show");
		setTimeout(function(){ $(".modal-success").modal("hide")}, 1500);
	}
}
