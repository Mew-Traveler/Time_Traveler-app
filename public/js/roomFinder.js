count = 0;
$(function(){

  // (window));
  $('#datetimepickerFrom').datetimepicker({
    timepicker:false,
    format: 'mm-dd-yyyy'

  });
  $('#datetimepickerTo').datetimepicker({
    timepicker:false,
    format: 'mm-dd-yyyy'

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
          console.log("s Funto get friends");
          $('#findSiteModal').modal('show');
          $.each(data["results_atrac"], function(index, element){
            $('#findSiteModal').find('.modal-body').append('<img src="'+element.icon+'" id="imagepreview" style="width: 20px; height: 20px;padding-right: 5px" >')
            if(element.rating){
              $('#findSiteModal').find('.modal-body').append('<span>✮'+element.rating+'</span>');
            }else{
              $('#findSiteModal').find('.modal-body').append('<span>Ni idea</span>');
            }
            $('#findSiteModal').find('.modal-body').append('<a onclick="sitechosen(this)" id="'+$("#searchSite").val()+"+"+element.placename+'"style="padding-left:5px">'+element.placename+'</a>');
            $('#findSiteModal').find('.modal-body').append('<br/>');
          })

  			},
  			// callback();
      	error: function(){
      		console.log("failed to get friends");
          $('#findSiteModal').modal('show');
          $('#findSiteModal').find('.modal-body').append('<p style="text-align:center;font-size:36px;color:red;">Google Restriction</p>');

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
          console.log("s to Parkget findparkbtn");
          $('#findSiteModal').modal('show');
          $.each(data["results_atrac"], function(index, element){
            $('#findSiteModal').find('.modal-body').append('<img src="'+element.icon+'" id="imagepreview" style="width: 20px; height: 20px;padding-right: 5px" >')
            if(element.rating){
              $('#findSiteModal').find('.modal-body').append('<span>✮'+element.rating+'</span>');
            }else{
              $('#findSiteModal').find('.modal-body').append('<span>Ni idea</span>');
            }
            $('#findSiteModal').find('.modal-body').append('<a onclick="sitechosen(this)" id="'+$("#searchSite").val()+"+"+element.placename+'"style="padding-left:5px">'+element.placename+'</a>');
            $('#findSiteModal').find('.modal-body').append('<br/>');
          })
      	},
      	error: function(){
      		console.log("failed to get friends");
          $('#findSiteModal').modal('show');
          $('#findSiteModal').find('.modal-body').append('<p style="text-align:center;font-size:36px;color:red;">Google Restriction</p>');

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
            $('#findSiteModal').find('.modal-body').append('<img src="'+element.icon+'" id="imagepreview" style="width: 20px; height: 20px;padding-right: 5px" >')
            if(element.rating){
              $('#findSiteModal').find('.modal-body').append('<span>✮'+element.rating+'</span>');
            }else{
              $('#findSiteModal').find('.modal-body').append('<span>Ni idea</span>');
            }
            $('#findSiteModal').find('.modal-body').append('<a onclick="sitechosen($(this))" id="'+$("#searchSite").val()+"+"+element.placename+'"style="padding-left:5px">'+element.placename+'</a>');
            $('#findSiteModal').find('.modal-body').append('<br/>');
          })
  			},
      	error: function(data){
      		console.log("failed to get friends"+data);
          $('#findSiteModal').modal('show');
          $('#findSiteModal').find('.modal-body').append('<p style="text-align:center;font-size:36px;color:red;">Google Restriction</p>');

      	}
      });
  });
}

function sitechosen(thisObj){
  ids = thisObj.attr('id').split("+");

  $('#sitesarea').append( '<p count="'+count+'" id="'+thisObj.attr('id')+'">'+ids[1]+"</p>" );
  count++;

  if(count>0){
    c = count-1;
    prv = $('p[count='+c+']').attr('id');
    console.log("---"+prv);
  }
  $.ajax({
      url:"/planificac/route/"+thisObj.attr('id')+"?ori="+prv,
      dataType: 'json',
      type: 'GET',
      success: function(data){
        console.log("sitechosen\n"+data.length);
      },
      error: function(data){
        console.log("failed to get friends"+data);
      }
    });
}
