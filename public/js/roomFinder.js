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

          $.each(data["results_atrac"], function(index, element) {
            $('#atrcslists a').append(
              '<a href=www.google.com>'+element.placename+'</a>'
            );

          });
  			},
      	error: function(data){
      		console.log("failed to get friends"+data);
      	}
      });
  });
}
