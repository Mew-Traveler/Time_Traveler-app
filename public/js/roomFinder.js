count = 0;
$(function(){


  // (window));
  $('#datetimepickerFrom').datetimepicker({
    timepicker:false,
    // format: 'mm-dd-yyyy'

  });
  $('#datetimepickerTo').datetimepicker({
    timepicker:false,
    //format: 'mm-dd-yyyy'

  });
  targetsAct();

  getPlanifica();
});

function getPlanifica(){
  $('#findFunbtn').on("click",function(){
    console.log("s dto get friends");

    $.ajax({
      	url:"/planificac/Wfind/"+$("#searchSite").val()+"?type="+"Fun",
      	dataType: 'json',
      	type: 'GET',
      	success: function(data){
          console.log("s Funto get friends");
          forchannel(data['channelId'],data['apiURL'],$("#searchSite").val(),"Fun");

          $('#findSiteModal').modal('show');
          // $.each(data["results_atrac"], function(index, element){
          //   $('#findSiteModal').find('.modal-body').append('<img src="'+element.icon+'" id="imagepreview" style="width: 20px; height: 20px;padding-right: 5px" >')
          //   if(element.rating){
          //     $('#findSiteModal').find('.modal-body').append('<span>✮'+element.rating+'</span>');
          //   }else{
          //     $('#findSiteModal').find('.modal-body').append('<span>Ni idea</span>');
          //   }
          //   $('#findSiteModal').find('.modal-body').append('<a onclick="sitechosen(this)" id="'+$("#searchSite").val()+"+"+element.placename+'"style="padding-left:5px">'+element.placename+'</a>');
          //   $('#findSiteModal').find('.modal-body').append('<br/>');
          // })

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

      	url:"/planificac/Wfind/"+$("#searchSite").val()+"?type="+"Park",
      	dataType: 'json',
      	type: 'GET',
      	success: function(data){
          console.log("s to Parkget findparkbtn");
          forchannel(data['channelId'],data['apiURL'],$("#searchSite").val(),"PARK");

          $('#findSiteModal').modal('show');
          // $.each(data["results_atrac"], function(index, element){
          //   $('#findSiteModal').find('.modal-body').append('<img src="'+element.icon+'" id="imagepreview" style="width: 20px; height: 20px;padding-right: 5px" >')
          //   if(element.rating){
          //     $('#findSiteModal').find('.modal-body').append('<span>✮'+element.rating+'</span>');
          //   }else{
          //     $('#findSiteModal').find('.modal-body').append('<span>Ni idea</span>');
          //   }
          //   $('#findSiteModal').find('.modal-body').append('<a onclick="sitechosen(this)" id="'+$("#searchSite").val()+"+"+element.placename+'"style="padding-left:5px">'+element.placename+'</a>');
          //   $('#findSiteModal').find('.modal-body').append('<br/>');
          // })
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
      	url:"/planificac/Wfind/"+$("#searchSite").val()+"?type="+"Restaurant",
      	dataType: 'json',
      	type: 'GET',
      	success: function(data){
          forchannel(data['channelId'],data['apiURL'],$("#searchSite").val(),"Restaurant");
          // console.log("s to get findResturantbtn\n"+data['results_atrac'].length);
          $('#findSiteModal').modal('show');
          // $.each(data["results_atrac"], function(index, element){
          //   $('#findSiteModal').find('.modal-body').append('<img src="'+element.icon+'" id="imagepreview" style="width: 20px; height: 20px;padding-right: 5px" >')
          //   if(element.rating){
          //     $('#findSiteModal').find('.modal-body').append('<span>✮'+element.rating+'</span>');
          //   }else{
          //     $('#findSiteModal').find('.modal-body').append('<span>Ni idea</span>');
          //   }
          //   $('#findSiteModal').find('.modal-body').append('<a onclick="sitechosen($(this))" types="restaurant" rating="'+element.rating+'"addr="'+element.address+'"id="'+$("#searchSite").val()+"+"+element.placename+'"style="padding-left:5px">'+element.placename+'</a>');
          //   $('#findSiteModal').find('.modal-body').append('<br/>');
          // })
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
  // console.log("sitechosen rating"+ele.rating);
  ids = thisObj.attr('id').split("+");
  c = count-1;
  $('#sitesarea').append( '<p count="'+count+'" id="'+thisObj.attr('id')+'">'+ids[1]+"</p>" );
  count++;
  console.log("roomFinder"+$('#nthday').val());
  console.log("roomFinder"+$('#project_id').val());

  $.ajax({
      url:"/planificac/create",
      contentType: "application/json; charset=utf-8",
      dataType: 'json',
      type: 'POST',
      data: JSON.stringify({
        project_id: $('#project_id').val(),
        // dailyplans_id: $('#ids').val(),
        type: thisObj.attr('types'),
        rating: thisObj.attr('rating'),
        site_name: ids[1],
        address: thisObj.attr('addr'),
        nthday: $('#nthday').val()
      }),
      success: function(data){
        console.log("target_save success");
      },
      error: function(){
        console.log("target_save failed");
      }
    });
  // if(count>0){
  //
  //   prv = $('p[count='+c+']').attr('id');
  //   console.log("---"+prv);
  // }
  // $.ajax({
  //     //url:"/planificac/route/"+thisObj.attr('id')+"?ori="+prv,
  //     url:"/planificac/route/Taipei?ori=Hsinchu",
  //     dataType: 'json',
  //     type: 'GET',
  //     success: function(data){
  //       console.log("sitechosen\n"+data.length);
  //     },
  //     error: function(data){
  //       console.log("failed to get friends"+data);
  //     }
  //   });
}

function forchannel(channelId,apiURL,loca,type){
    var channel = channelId;
    var client = new Faye.Client(apiURL+"/faye");
    // var bar = document.getElementsByClassName("progress-bar")[0];
    var bar = $(".progress-bar").eq(0);
    var reg = /\:(\d+)%/
    client.subscribe('/' + channel, function(message) {
      var progress = bar.getAttribute("style")
      var currentProgress = reg.exec(progress)[1]

      if (isNaN(message)) {
        bar.setAttribute("style", "width:100%")
        bar.setAttribute("class", "progress-bar progress-bar-danger progress-bar-striped")
        bar.innerHTML = message
      } else {
        if (parseInt(message) > parseInt(currentProgress)) {
          bar.setAttribute("aria-valuenow", message)
          bar.setAttribute("style", "width:"+message+"%")
          bar.innerHTML = message+"%"

          if (message == "100") {
            setTimeout(function () {
              getDBplac(loca,type);
              window.location = window.location.href.split('?')[0]
            }, 2000);
          }
        }
      }
    });

}
function getDBplac(locat,type){
  $.ajax({
      url:"/planificac/find/"+locat+"?type="+type,
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
          $('#findSiteModal').find('.modal-body').append('<a onclick="sitechosen($(this))" types="restaurant" rating="'+element.rating+'"addr="'+element.address+'"id="'+$("#searchSite").val()+"+"+element.placename+'"style="padding-left:5px">'+element.placename+'</a>');
          $('#findSiteModal').find('.modal-body').append('<br/>');
        })
      },
      error: function(data){
        console.log("failed to get friends"+data);
        $('#findSiteModal').modal('show');
        $('#findSiteModal').find('.modal-body').append('<p style="text-align:center;font-size:36px;color:red;">Google Restriction</p>');

      }
    });
}
function targetsAct(){
  $('#target_cancel').on("click",function(){
    projectName = $('#projectName').val();
    projectDays = $('#projectDays').val();
    userEmail = $('#userEmail').val();
    nthday = $('#nthday').val();
    project_id = $('#project_id').val();
    window.location.href='/goto/project?projectName='+projectName+'&projectDays='+projectDays+'&userEmail='+userEmail+'&nthday='+nthday+'&project_id='+project_id;
  });

  $('#target_save').on("click",function(){
    $.ajax({
        url:"/planificac/create/",
        type: 'POST',
        success: function(){
          console.log("target_save success");
        },
        error: function(){
          console.log("target_save failed");
        }
      });
  });
}
