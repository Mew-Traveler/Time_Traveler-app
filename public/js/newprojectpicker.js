$(function () {
        $('#datetimepickerFrom').datetimepicker();
        $('#datetimepickerTo').datetimepicker();
        $('#datepickerstarttiming').datetimepicker({
          format: 'HH:ii p',
              autoclose: true,
              // todayHighlight: true,
              showMeridian: true,
              startView: 1,
              maxView: 1
         });
         $('#datepickerendtiming').datetimepicker({
           format: 'HH:ii p',
               autoclose: true,
               // todayHighlight: true,
               showMeridian: true,
               startView: 1,
               maxView: 1
          });
          BnbChosen();
          DailySaved();
          getPlanifica();
  });

function BnbChosen(){
  $('.aaf').on("click",function(){
    console.log(".aad");
    var text = $( this ).text();
    $('#destbnb').val(text);
    var id = $(this).attr('data-id');
    $('#bnbid').val(id);
  })
}

function DailySaved(){
  $('#savedaily').on("click",function(){
    console.log(".savedaily");
    console.log($('#destbnb').val());
    console.log($('#oribnb').val());
    console.log($('#starttiming').val());
    console.log($('#nthday').val());

    $.ajax({
  		url: "/daily/basic",
  		type: "POST",
  		contentType: "application/json; charset=utf-8",
  		dataType: "json",
  		data: JSON.stringify({
  			projectId: $('#ids').val(),
  			roomId: $('#bnbid').val(),
        nthday:$('#nthday').val(),
        timeStart:$('#starttiming').val(),
        timeEnd:$('#endtiming').val(),
        locateStart:$('#oribnb').val(),
        locateEnd:$('#destbnb').val(),
  		}),
  		success: function(data){
        alert('你成功建立新群組『'+$('#ids').val()+'』');

  			console.log($('#nthday').val());
        window.location.href = "/buildshedule/"+$('#ids').val()+"/"+$('#nthday').val();

  		},
  		error:function (jqXHR, textStatus, errorThrown) {

            console.log(jqXHR);
        }
  	});
  });
}
function getPlanifica(){
  $('#findatraxbtn').on("click",function(){
    console.log("s dto get friends");

    $.ajax({
      	url:"/planificac/find/"+$("#findatrac").val()+"?type="+"Fun",
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
  $('#findparkbtn').on("click",function(){
    console.log("s findparkbtn get friends");

    $.ajax({

      	url:"/planificac/find/"+$("#findatrac").val()+"?type="+"Park",
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
      	url:"/planificac/find/"+$("#findatrac").val()+"?type="+"Restaurant",
      	dataType: 'json',
      	type: 'GET',
      	success: function(data){
          console.log("s to get findResturantbtn\n"+JSON.stringify(data["results_atrac"]));

  			},
  			// callback();

      	error: function(data){
      		console.log("failed to get friends"+data);
      	}
      });
  });
}
