$(function(){

  // (window));
  $('#datetimepickerFrom').datetimepicker({
    timepicker:false,
    format: 'dd-mm-yyyy'

  });
  $('#datetimepickerTo').datetimepicker({
    timepicker:false,
    format: 'dd-mm-yyyy'

  });
  getPlanifica();
});

function getPlanifica(){
  $('#findFunbtn').on("click",function(){
    console.log("s dto get friends");

    $.ajax({
      	url:"/planificac/find/"+$("#searchSite").val()+"?type="+"Fun",
      	dataType: 'json',
      	type: 'GET',
      	success: function(data){
          console.log("s to get friends");

  			},
  			// callback();
      	error: function(){
      		console.log("failed to get friends");
      	}
      });
  });
  $('#findParkbtn').on("click",function(){
    console.log("s findparkbtn get friends");

    $.ajax({

      	url:"/planificac/find/"+$("#searchSite").val()+"?type="+"Park",
      	dataType: 'json',
      	type: 'GET',
      	success: function(data){
          console.log("s to get findparkbtn");
      	},
      	error: function(){
      		console.log("failed to get friends");
      	}
      });
  });

  $('#findResturantbtn').on("click",function(){
    console.log("s findResturantbtn get friends");

    $.ajax({
      	url:"/planificac/find/"+$("#searchSite").val()+"?type="+"Restaurant",
      	dataType: 'json',
      	type: 'GET',
      	success: function(data){
          console.log("s to get findResturantbtn\n"+data['results_atrac'].length);
          $('#findSiteModal').modal('show');
          $.each(data["results_atrac"], function(index, element){
            $('#findSiteModal').find('.modal-body').append('<img src="'+element.icon+'" id="imagepreview" style="width: 20px; height: 20px; padding-right: 5px" >')

            $('#findSiteModal').find('.modal-body').append('<a>'+element.placename+'</a>');

            $('#findSiteModal').find('.modal-body').append('<br/>');
          })

          // $.each(data["results_atrac"], function(index, element) {
          //   $('#atrcslists a').append(
          //     '<a href=www.google.com>'+element.placename+'</a>'
          //   );
          //
          // });
  			},
      	error: function(data){
      		console.log("failed to get friends"+data);
      	}
      });
  });
}
